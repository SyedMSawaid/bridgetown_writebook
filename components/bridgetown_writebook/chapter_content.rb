module BridgetownWritebook
  class ChapterContent < Bridgetown::Component
    def initialize(chapter:)
      @chapter = chapter
    end

    def template
      <<~HTML
        #{@chapter.resource.content}
        <div data-controller="reading"
             data-reading-id-value="#{@chapter.id}"
             data-reading-book-value="#{@chapter.book.id}">
        </div>
      HTML
    end
  end
end