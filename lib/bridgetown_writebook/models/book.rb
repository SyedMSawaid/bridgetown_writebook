# frozen_string_literal: true

require_relative "chapter"

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
          @chapters << Chapter.new(chapter, book: self)
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

      def extract_metadata # rubocop:disable Metrics/CyclomaticComplexity
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

      def generate # rubocop:disable Metrics/AbcSize
        resource.data.layout = "bridgetown_writebook/book"
        resource.data.title = title
        resource.data.cover = cover
        resource.data.subtitle = subtitle
        resource.data.authors = authors
        resource.content = BridgetownWritebook::BookContent.new(book: self).template

        chapters.each(&:generate)
      end
    end
  end
end
