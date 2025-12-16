# frozen_string_literal: true

module BridgetownWritebook
  class ChapterContent < Bridgetown::Component
    def initialize(chapter:)
      super
      @chapter = chapter
    end

    def template
      html do
        text_node @chapter.resource.content
        div data: {
          controller: "reading",
          reading_id_value: @chapter.id,
          reading_book_value: @chapter.book.id,
        }
      end
    end
  end
end
