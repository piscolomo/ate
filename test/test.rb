require File.expand_path("../lib/ate", File.dirname(__FILE__))

scope do
  test "returning same number of empty lines" do
    example = Ate.parse("\n\n \n")
    assert_equal "\n\n \n", example.call
  end
  test "returning same number of empty lines with mixed code" do
    example = Ate.parse("\n% true\n\n% false\n\n")
    assert_equal "\n\n", example.call
  end

  test "looking a file" do
    assert_equal "Beetlejuice\nBeetlejuice\nBeetlejuice\n", Ate.parse("% 3.times do\nBeetlejuice\n% end").call
  end
end