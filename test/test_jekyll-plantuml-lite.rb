require "minitest/autorun"
require_relative "../lib/jekyll-plantuml-lite"
require "liquid"
require 'webmock/minitest'

class HolaTest < Minitest::Test
  def test_writes_inline_svg
    stub_request(
      :get, 
      "https://www.plantuml.com/plantuml/svg/TO-n3e8m54NtznLlX3WO1vTM2T_WZCCJ7lX2RKbRYIRuxzQ02z7rd9kJt394yl5-Cw1EJCrJWxByY9dBfm-fMKQndOOm68d9KPz9VW1KLFTfLCm2gIEn2vtzKW5q5WEFxCcW4SjXIb9G7L5mWxlptnHx_qtHBzywjrsX2_cgMZ710lSl2D4DmBR1vKWhLi9LGvbOUly6"
    ).to_return(
      body: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><svg>this is a test response</svg>",
      status: 200
    )

    assert_rendered_result_as_expected_for_requested_markup(
      "<svg>this is a test response</svg>",
      "{% plantuml %}#{File.read("test/data/request.txt")}{% endplantuml %}"
    )
  end

  def assert_rendered_result_as_expected_for_requested_markup(expected, markup)
    assert_equal expected, Liquid::Template.parse(markup).render()
  end
end