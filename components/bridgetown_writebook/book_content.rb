# frozen_string_literal: true

module BridgetownWritebook
  class BookContent < Bridgetown::Component
    def initialize(book:)
      super()
      @book = book
    end

    def template
      data_attrs = [
        'data-controller="bookmark"',
        'data-bookmark-chapter-outlet=".chapter"',
        "data-bookmark-book-value=\"#{@book.id}\"",
      ].join(" ")

      "<ul class=\"book-content-list\" #{data_attrs}>#{chapters_list}</ul>"
    end

    def chapters_list
      @book.chapters.map do |chapter|
        BridgetownWritebook::ChapterListItem.new(chapter: chapter).template
      end.join
    end
  end
end
