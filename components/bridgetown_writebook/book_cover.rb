module BridgetownWritebook
  class BookCover < Bridgetown::Component
    attr_accessor :book

    def initialize(book:)
      @book = book
    end

    def template
      chapters_json = book.chapter_ids.to_json.gsub('"', "&quot;")
      <<~HTML
        <li class="book-cover-item" data-controller="book" data-book-id-value="#{book.id}" data-book-chapters-value="#{chapters_json}" >
          <a class="book-cover-link" href="#{book.link}">
            <div class="book-cover-image-wrapper" data-book-target="cover">
              <img src="#{book.cover}" class="book-cover-image">
            </div>
            <div class="book-cover-title">#{book.name}</div>
            <div class="book-cover-authors">#{book.authors}</div>
          </a>
        </li>
      HTML
    end
  end
end
