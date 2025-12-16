module BridgetownWritebook
  class BookContent < Bridgetown::Component
    def initialize(book:)
      @book = book
    end

    def template
      <<~HTML
        <ul class="book-content-list"
            data-controller="bookmark"
            data-bookmark-chapter-outlet='.chapter'
            data-bookmark-book-value="#{@book.id}">
         #{chapters_list}
        </ul>
      HTML
    end

    def chapters_list
      @book.chapters.map do |chapter|
        BridgetownWritebook::ChapterListItem.new(chapter: chapter).template
      end.join
    end
  end
end
