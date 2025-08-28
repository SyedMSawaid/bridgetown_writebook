# frozen_string_literal: true

module BridgetownWritebook
  module Commands
    class Chapter < Thor
      desc "add", "Add a new chapter to a book"
      option :book, type: :string, required: true, desc: "Title of the book"
      option :title, type: :string, required: true, desc: "Title of the chapter"
      def add
        book_title = options[:book]
        chapter_title = options[:title]
        @folder_path = File.join("src", "_books", book_title.parameterize)

        unless Dir.exist?(@folder_path)
          Bridgetown.logger.info "Book not found: #{book_title}"
          return
        end

        chapter_file = File.join(@folder_path, "#{new_chapter_number}-#{chapter_title.parameterize}.md")

        content = <<~MARKDOWN
          ---
          title: #{chapter_title}
          ---
        MARKDOWN

        File.write(chapter_file, content)
        Bridgetown.logger.info "Chapter created: #{chapter_file}"
      end

      private

      def new_chapter_number
        existing_chapters = Dir.children(@folder_path)
          .grep(%r{^\d{2}-.*\.md$})
          .sort
        last_number = if existing_chapters.empty?
                        0
                      else
                        existing_chapters.last.split("-").first.to_i
                      end

        format("%02d", last_number + 1)
      end
    end
  end
end
