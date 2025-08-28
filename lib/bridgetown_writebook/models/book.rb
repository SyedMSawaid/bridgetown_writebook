# frozen_string_literal: true

module BridgetownWritebook
  module Models
    class Book
      attr_accessor :name, :subtitle, :resource, :meta, :chapters

      delegate :id, to: :resource
      alias_method :title, :name

      def initialize(book, chapters:, meta:)
        @resource = book
        @meta = meta
        @chapters = []

        chapters.each do |chapter|
          @chapters << Chapter.new(chapter, booxk: self)
        end

        extract_metadata
      end

      #TODO: support other formats as well.
      def cover
        "/#{resource.path.split(".").first}/cover.png"
      end

      def authors?
        @authors.present?
      end

      def authors
        "by #{@authors.join(", ")}" if authors?
      end

      def extract_metadata
        @name = @meta&.data&.title || slug.titleize
        @subtitle = @meta&.data&.subtitle
        @authors = @meta&.data&.authors
      end

      def slug
        id.split("/").last.split(".md").first
      end

      def link
        resource.relative_url
      end

      def chapter_ids
        chapters.map(&:id)
      end

      def generate
        resource.data.layout = :book
        resource.data.title = title
        resource.data.cover = cover
        resource.data.subtitle = subtitle
        resource.data.authors = authors
        resource.content = content

        chapters.each(&:generate)
      end

      def content
        <<~HTML
          <ul class="pl-0" data-controller="bookmark" data-bookmark-chapter-outlet='.chapter' data-bookmark-book-value="#{id}">
           #{chapters.map do |chapter|
             li chapter
           end.join }
          </ul>
        HTML
      end

      # TODO: may be convert these into compenents or partials.
      # TODO: Move them to the template, add it to the metadata and move it to the template.
      def li(chapter)
        <<~HTML
          <li class='chapter flex justify-between items-end gap-4'
              data-controller='chapter'
              data-chapter-id-value='#{chapter.id}'
              data-chapter-ellipsis-class="text-orange-500"
          >
            <a href='#{chapter.link}' class="text-nowrap">#{chapter.title}</a>
            <span class="grow overflow-hidden border-b border-dotted border-black mb-1.5" data-chapter-target="ellipsis"></span>
            <span class="text-nowrap">#{chapter.word_count}</span>
          </li>
        HTML
      end
    end
  end
end
