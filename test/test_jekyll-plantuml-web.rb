require "minitest/autorun"
require_relative "../lib/jekyll-plantuml-web"
require "liquid"

class HolaTest < Minitest::Test
  def test_
    context = Liquid::ParseContext.new
    plugin = Jekyll::JekyllPlantUmlWeb.send :new, 'plantuml', 'sometext', context

    assert_equal "SrJGjLDmibBmICt9oGS0", plugin.render(context)
  end
end