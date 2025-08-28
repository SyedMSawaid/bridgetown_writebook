# frozen_string_literal: true

require_all "bridgetown-core/commands/concerns"
require "commands/book"

module BridgetownWritebook
  class Commands
    include Bridgetown::Commands::ConfigurationOverridable

    Bridgetown::Commands::Registrations.register do
      desc "book <command>", "Take me to the book"
      subcommand "book", Book
    end
  end
end
