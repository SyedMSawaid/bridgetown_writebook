# frozen_string_literal: true

module BridgetownWritebook
  class Builder < Bridgetown::Builder
    def build
      liquid_tag "bridgetown_writebook" do
        "This plugin works!"
      end

      liquid_tag "what" do
        "is going on"
      end
    end
  end
end
