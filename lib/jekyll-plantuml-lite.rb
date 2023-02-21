require "jekyll"
require "liquid"
require_relative "main.rb"

module Jekyll
    class JekyllPlantUmlLite < Liquid::Block
        def initialize(tag_name, text, tokens)
            super
            print "tag name: " + tag_name
            print "text: " + text
            print "tokens: " + tokens
        end

        def render(context)
            content = super
            return Main.new.to_plantuml content
        end
    end
end

Liquid::Template.register_tag('plantuml', Jekyll::JekyllPlantUmlLite)