# frozen_string_literal: true

module BridgetownWritebook
  class BookContent < Bridgetown::Component
    def initialize(book:)
      super
      @book = book
    end

    def template
      html do
        ul class: "book-content-list",
           data: {
             controller: "bookmark",
             bookmark_chapter_outlet: ".chapter",
             bookmark_book_value: @book.id,
           } do
          text_node chapters_list.join
        end
      end
    end

    def chapters_list
      @book.chapters.map do |chapter|
        BridgetownWritebook::ChapterListItem.new(chapter: chapter).template
      end.join
    end
  end
end
