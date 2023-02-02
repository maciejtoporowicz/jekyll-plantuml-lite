require "jekyll"
require "liquid"
require_relative "encoder.rb"

module Jekyll
    class JekyllPlantUmlWeb < Liquid::Block
        def initialize(tag_name, text, tokens)
            super
            puts "tag name #{tag_name}"
            puts "text #{text}"
            puts "tokens #{tokens.inspect}"
            @text = text
        end

        def render(context)
            content = super
            return Encoder.new.encode(content)
        end
    end
end

Liquid::Template.register_tag('plantuml', Jekyll::JekyllPlantUmlWeb)