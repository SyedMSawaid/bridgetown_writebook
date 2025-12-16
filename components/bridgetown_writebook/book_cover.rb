# frozen_string_literal: true

module BridgetownWritebook
  class BookCover < Bridgetown::Component
    attr_accessor :book

    def initialize(book:)
      super
      @book = book
    end

    def template
      html do
        li class: "book-cover-item",
           data: cover_data_attributes do
          a class: "book-cover-link", href: book.link do
            render_cover_image
            render_book_title
            render_book_authors
          end
        end
      end
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
      div class: "book-cover-image-wrapper",
          data: { book_target: "cover" } do
        img src: book.cover, class: "book-cover-image"
      end
    end

    def render_book_title
      div class: "book-cover-title" do
        text_node book.name
      end
    end

    def render_book_authors
      div class: "book-cover-authors" do
        text_node book.authors
      end
    end
  end
end
