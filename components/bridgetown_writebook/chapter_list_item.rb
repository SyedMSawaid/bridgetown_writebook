module BridgetownWritebook
  class ChapterListItem < Bridgetown::Component
    attr_accessor :chapter

    def initialize(chapter:)
      @chapter = chapter
    end

    def template
      <<~HTML
        <li class='chapter'
            data-controller='chapter'
            data-chapter-id-value='#{chapter.id}'
            data-chapter-ellipsis-class="chapter-highlight"
        >
          <a href='#{chapter.link}' class="chapter-link">#{chapter.title}</a>
          <span class="chapter-ellipsis" data-chapter-target="ellipsis"></span>
          <span class="chapter-word-count">#{chapter.word_count}</span>
        </li>
      HTML
    end
  end
end
