# frozen_string_literal: true

module BridgetownWritebook
  class BookList < Bridgetown::Component
    def initialize(books:)
      super()
      @books = books
    end

    def book_covers
      @books.map { |book| BridgetownWritebook::BookCover.new(book: book).template }.join
    end

    def template
      "<ul class=\"book-list\">#{book_covers}</ul>"
    end
  end
end
