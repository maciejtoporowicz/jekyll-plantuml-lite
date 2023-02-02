require "minitest/autorun"
require_relative "../lib/jekyll-plantuml-web"
require "liquid"
require 'webmock/minitest'

class HolaTest < Minitest::Test
  def test_writes_inline_svg_when_content_is_valid
    stub_request(
      :get, 
      "https://www.plantuml.com/plantuml/svg/SoWkIImgAStDuNBAJrBGjLDmpCbCJbMmKiX8pSd9vt98pKi1IW80"
    ).to_return(
      body: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><svg>this is a test response</svg>",
      status: 200
    )

    assert_rendered_result(
      "<svg>this is a test response</svg>",
      "{% plantumlweb %}#{File.read("test/data/input.txt")}{% endplantumlweb %}"
    )
  end

  def test_writes_inline_svg_when_content_is_not_valid
    stub_request(
      :get, 
      "https://www.plantuml.com/plantuml/svg/SoWkIImgAStDuNBAJrBGjLDmpCbCJbMmKiX8pSd9vt98pKi1IW80"
    ).to_return(
      body: "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><svg>this is an invalid response</svg>",
      status: 400
    )

    assert_rendered_result(
      "<svg>this is an invalid response</svg>",
      "{% plantumlweb %}#{File.read("test/data/input.txt")}{% endplantumlweb %}"
    )
  end

  def assert_rendered_result(expected, markup)
    assert_equal expected, Liquid::Template.parse(markup).render()
  end
end