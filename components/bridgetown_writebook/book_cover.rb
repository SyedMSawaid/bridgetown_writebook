module BridgetownWritebook
  class BookCover < Bridgetown::Component
    attr_accessor :book

    def initialize(book:)
      @book = book
    end

    def template
      chapters_json = book.chapter_ids.to_json.gsub('"', "&quot;")
      <<~HTML
        <li data-controller="book" data-book-id-value="#{book.id}" data-book-chapters-value="#{chapters_json}" >
          <a class="flex flex-col gap-2 max-w-[236px]" href="#{book.link}">
            <div class="max-h-[378px] border rounded relative box-border" data-book-target="cover">
              <img src="#{book.cover}" class="max-h-[378px] max-w-[236px] rounded">
            </div>
            <div class="text-center">#{book.name}</div>
            <div class="text-sm text-center">#{book.authors}</div>
          </a>
        </li>
      HTML
    end
  end
end