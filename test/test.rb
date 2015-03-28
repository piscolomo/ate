require File.expand_path("../lib/ate", File.dirname(__FILE__))

scope do
  test "just veryfing" do
    content = Ate.parse
    assert_equal "gogo ate-callao!", content
  end
end