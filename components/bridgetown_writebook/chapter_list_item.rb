# frozen_string_literal: true

module BridgetownWritebook
  class ChapterListItem < Bridgetown::Component
    attr_accessor :chapter

    def initialize(chapter:)
      super
      @chapter = chapter
    end

    def template
      html do
        li class: "chapter",
           data: {
             controller: "chapter",
             chapter_id_value: chapter.id,
             chapter_ellipsis_class: "chapter-highlight",
           } do
          a class: "chapter-link", href: chapter.link do
            text_node chapter.title
          end
          span class: "chapter-ellipsis", data: { chapter_target: "ellipsis" }
          span class: "chapter-word-count" do
            text_node chapter.word_count
          end
        end
      end
    end
  end
end
