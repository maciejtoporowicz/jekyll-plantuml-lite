require "minitest/autorun"
require_relative "../lib/encoder"

class HolaTest < Minitest::Test
  def test_encoding
    encoder = Encoder.new

    assert_equal "ImG0", encoder.encode("a")
    assert_equal "Iqm20000", encoder.encode("ab")
    assert_equal "IqnA1W00", encoder.encode("abc")
    assert_equal "IqnAJW40", encoder.encode("abcd")
    assert_equal "IqnAJaa50000", encoder.encode("abcde")
  end
end