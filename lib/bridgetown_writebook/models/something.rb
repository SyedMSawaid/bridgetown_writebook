require 'active_support/core_ext/numeric/conversions'

# frozen_string_literal: true
class Builders::Books < SiteBuilder
  def initialize(name = nil, current_site = nil)
    super
    @books = []
  end

  def build
    generator do
      create_book_objects
      generate_books
      generate_index_page_for_books
    end
  end

  def generate_index_page_for_books
    books = @books
    book_covers = books.map { |book| cover_for(book) }.join
    add_resource nil, "books.md" do
      layout "default"
      permalink "/books/"
      content <<-HTML
<ul class="list-none flex justify-center sm:grid sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-y-6 py-10 px-0 flex-wrap">
    #{book_covers}
</ul>
HTML
    end
  end

  def cover_for(book)
    chapters_json = book.chapter_ids.to_json.gsub('"', '&quot;')

    <<-HTML
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

  def create_book_objects
    site.collections.books.resources
        .group_by { |b| b.id.split("_books/").last.split("/").first }
        .each do |book_id, chapters|
          meta_file = chapters.find { |c| c.relative_path.to_s.end_with?('00-meta.md') }
          regular_chapters = chapters.reject { |c| c.relative_path.to_s.end_with?('00-meta.md') }

          resource = add_resource(:book, "books/#{book_id}.md") { permalink "/books/:slug/" }
          @books << Book.new(resource, chapters: regular_chapters, meta: meta_file)
        end
  end

  def generate_books
    @books.each(&:generate)
  end
end