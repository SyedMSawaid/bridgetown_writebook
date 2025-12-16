# frozen_string_literal: true

module BridgetownWritebook
  class BookList < Bridgetown::Component
    def initialize(books:)
      super
      @books = books
    end

    def book_covers
      @books.map { |book| BridgetownWritebook::BookCover.new(book: book).template }.join
    end

    def template
      html do
        ul class: "book-list" do
          text_node book_covers
        end
      end
    end
  end
end
