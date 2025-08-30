module BridgetownWritebook
  class ChapterListItem < Bridgetown::Component
    attr_accessor :chapter

    def initialize(chapter:)
      @chapter = chapter
    end

    def template
      <<~HTML
        <li class='chapter flex justify-between items-end gap-4'
            data-controller='chapter'
            data-chapter-id-value='#{chapter.id}'
            data-chapter-ellipsis-class="text-orange-500"
        >
          <a href='#{chapter.link}' class="text-nowrap">#{chapter.title}</a>
          <span class="grow overflow-hidden border-b border-dotted border-black mb-1.5" data-chapter-target="ellipsis"></span>
          <span class="text-nowrap">#{chapter.word_count}</span>
        </li>
      HTML
    end
  end
end