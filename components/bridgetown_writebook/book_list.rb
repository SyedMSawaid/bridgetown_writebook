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
        <ul class="list-none flex justify-center sm:grid sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-y-6 py-10 px-0 flex-wrap">
            #{book_covers}
        </ul>
      HTML
    end
  end
end