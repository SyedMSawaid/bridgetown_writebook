# frozen_string_literal: true

require "active_support/core_ext/numeric/conversions"
require_relative "models/book"
require_relative "models/chapter"

module BridgetownWritebook
  class Builder < Bridgetown::Builder
    def initialize(name = nil, current_site = nil)
      Bridgetown.logger.info "Generating books..."
      super
      @books = []
    end

    def build
      generator do
        Bridgetown.logger.info "Running book generator..."
        create_book_objects
        generate_books
        generate_index_page_for_books
      end
    end

    def generate_index_page_for_books
      template = BridgetownWritebook::BookList.new(books: @books).template
      add_resource :pages, "books.md" do
        layout "default"
        permalink "/books/"
        content template
      end
    end

    def create_book_objects # rubocop:disable Metrics/AbcSize
      site.collections.books.resources
        .group_by { |b| b.id.split("_books/").last.split("/").first }
        .each do |book_id, chapters|
        meta_file = chapters.find { |c| c.relative_path.to_s.end_with?("00-meta.md") }
        regular_chapters = chapters.reject { |c| c.relative_path.to_s.end_with?("00-meta.md") }

        resource = add_resource(:book, "books/#{book_id}.md") { permalink "/books/:slug/" }
        @books << BridgetownWritebook::Models::Book.new(
          resource, chapters: regular_chapters, meta: meta_file
        )
      end
    end

    def generate_books
      @books.each(&:generate)
    end
  end
end
