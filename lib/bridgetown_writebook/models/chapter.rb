# frozen_string_literal: true

module BridgetownWritebook
  module Models
    class Chapter
      attr_accessor :name, :slug, :resource, :book

      delegate :id, :data, to: :resource

      def initialize(chapter, book:)
        @resource = chapter
        @book = book

        # Populate the word count before adding the stimulus controller
        calculate_word_count
      end

      def calculate_word_count
        words_array = resource.content.split - %w[#]
        @word_count = words_array.size
      end

      def delimited_word_count
        @word_count.to_fs(:delimited)
      end

      def word_count
        return "#{delimited_word_count} words" if @word_count > 1

        "#{delimited_word_count} word"
      end

      def link
        resource.relative_url
      end

      def title
        data.title
      end

      def next_chapter
        book.chapters[book.chapters.index(self) + 1]
      end

      def generate
        resource.data.layout = "chapter"
        resource.data.book_title = book.name
        resource.data.book_link = book.link
        resource.data.next_chapter_title = next_chapter&.title
        resource.data.next_chapter_link = next_chapter&.link
        resource.data.word_count = word_count
        resource.content = <<~HTML
          #{html resource.content}
          <div data-controller="reading"
               data-reading-id-value="#{text id}"
               data-reading-book-value="#{text book.id}">
          </div>
        HTML
      end
    end
  end
end
