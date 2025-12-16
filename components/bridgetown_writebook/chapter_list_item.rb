# frozen_string_literal: true

module BridgetownWritebook
  class ChapterListItem < Bridgetown::Component
    attr_accessor :chapter

    def initialize(chapter:)
      super()
      @chapter = chapter
    end

    def template
      data_attrs = [
        'data-controller="chapter"',
        "data-chapter-id-value=\"#{chapter.id}\"",
        'data-chapter-ellipsis-class="chapter-highlight"',
      ].join(" ")

      link = "<a class=\"chapter-link\" href=\"#{chapter.link}\">#{chapter.title}</a>"
      ellipsis = '<span class="chapter-ellipsis" data-chapter-target="ellipsis"></span>'
      word_count = "<span class=\"chapter-word-count\">#{chapter.word_count}</span>"

      "<li class=\"chapter\" #{data_attrs}>#{link}#{ellipsis}#{word_count}</li>"
    end
  end
end
