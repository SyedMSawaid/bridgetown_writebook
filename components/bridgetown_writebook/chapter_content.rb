# frozen_string_literal: true

module BridgetownWritebook
  class ChapterContent < Bridgetown::Component
    def initialize(chapter:)
      super()
      @chapter = chapter
    end

    def template
      data_attrs = [
        'data-controller="reading"',
        "data-reading-id-value=\"#{@chapter.id}\"",
        "data-reading-book-value=\"#{@chapter.book.id}\"",
      ].join(" ")

      "#{@chapter.resource.content}<div #{data_attrs}></div>"
    end
  end
end
