module BridgetownWritebook
  class BookList < Bridgetown::Component
    def initialize(books:)
      @books = books
    end

    def book_covers
      @books.map { |book| BridgetownWritebook::BookCover.new(book: book).template }.join
    end

    def template
      <<~HTML
        <ul class="book-list">
            #{book_covers}
        </ul>
      HTML
    end
  end
end
