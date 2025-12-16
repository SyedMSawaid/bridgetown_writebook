# frozen_string_literal: true

module BridgetownWritebook
  class BookCover < Bridgetown::Component
    attr_accessor :book

    def initialize(book:)
      super()
      @book = book
    end

    def template
      data_attrs = cover_data_attributes.map do |k, v|
        %(data-#{k.to_s.tr("_", "-")}="#{v}")
      end.join(" ")

      link_inner = [
        render_cover_image,
        render_book_title,
        render_book_authors,
      ].join

      "<li class=\"book-cover-item\" #{data_attrs}><a class=\"book-cover-link\" href=\"#{book.link}\">#{link_inner}</a></li>"
    end

    private

    def cover_data_attributes
      chapters_json = book.chapter_ids.to_json.gsub('"', "&quot;")
      {
        controller: "book",
        book_id_value: book.id,
        book_chapters_value: chapters_json,
      }
    end

    def render_cover_image
      '<div class="book-cover-image-wrapper" data-book-target="cover">' \
        + "<img src=\"#{book.cover}\" class=\"book-cover-image\" />" \
        + "</div>"
    end

    def render_book_title
      "<div class=\"book-cover-title\">#{book.name}</div>"
    end

    def render_book_authors
      "<div class=\"book-cover-authors\">#{book.authors}</div>"
    end
  end
end
