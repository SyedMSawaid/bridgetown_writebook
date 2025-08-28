# frozen_string_literal: true

require_all "bridgetown-core/commands/concerns"
require_relative "chapter"

module BridgetownWritebook
  module Commands
    class Book < Thor
      include Bridgetown::Commands::ConfigurationOverridable

      Bridgetown::Commands::Registrations.register do
        desc "book <command>", "Take me to the book"
        subcommand "book", Book
      end

      desc "setup", "Setup folders and files for books"
      def setup
        create_books_folder
        add_books_collection_to_config
      end

      desc "new", "Create a new book"
      option :title, type: :string, required: true, desc: "Title of the book"
      def new
        title = options[:title]
        folder_path = File.join("src", "_books", title.parameterize)

        if Dir.exist?(folder_path)
          Bridgetown.logger.info "Folder already exists: #{folder_path}"
        else
          FileUtils.mkdir_p(folder_path)
          Bridgetown.logger.info "Folder created: #{folder_path}"
        end

        file_path = File.join(folder_path, "00-meta.md")
        content = <<~MARKDOWN
          ---
          title: #{text title}
          subtitle:
          authors: [  ]
          ---
        MARKDOWN

        File.write(file_path, content)
        Bridgetown.logger.info "Creating a new book with title: #{title}"
      end

      # Register Chapters as a nested subcommand
      desc "chapters <command>", "Manage chapters of a book"
      subcommand "chapters", Chapter

      private

      def create_books_folder
        folder_path = File.join("src", "_books")

        if Dir.exist?(folder_path)
          Bridgetown.logger.info "Folder already exists: #{folder_path}"
        else
          FileUtils.mkdir_p(folder_path)
          Bridgetown.logger.info "Folder created: #{folder_path}"
        end
      end

      def add_books_collection_to_config
        config_file = "bridgetown.config.yml"
        unless File.exist?(config_file)
          Bridgetown.logger.info "Config file not found: #{config_file}"
          return
        end

        content = File.read(config_file)
        if content.include?("books:")
          Bridgetown.logger.info "'books' collection already exists, skipping..."
          return
        end

        config = YAML.load_file(config_file) || {}
        config["collections"] ||= {}
        config["collections"]["books"] = {
          "output"    => true,
          "permalink" => "/books/:path/",
        }

        File.write(config_file, config.to_yaml)
        Bridgetown.logger.info "'books' collection added/updated in #{config_file}"
      end
    end
  end
end
