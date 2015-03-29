require File.expand_path("../lib/ate", File.dirname(__FILE__))

scope do
  test "returning same number of empty lines" do
    example = Ate.parse("\n \n\n  \n")
    assert_equal "\n \n\n  \n", example.call
  end
  test "returning same number of empty lines with code" do
    example = Ate.parse("\n% false\n% true\n\n%true")
    assert_equal "\n\n", example.call
  end

  test "empty lines with conditional" do
    example = Ate.parse("\n% if true\n\n\n% else\n\n% end\n")
    assert_equal "\n\n\n", example.call
  end

  test "printing string" do
    example = Ate.parse("{{ \"Hello World!\" }}")
    assert_equal "Hello World!\n", example.call
  end

  test "comment" do
    template = (<<-EOT).gsub(/ /, "")
    Awesome
    % # i'm a comment
    ATE
    EOT

    example = Ate.parse(template)
    assert_equal "Awesome\nATE\n", example.call
  end

  test "respecting first empty spaces of lines" do
    template = "  Hi, Juan\n    Bye, I don't have time for this."
    example = Ate.parse(template)
    assert_equal "  Hi, Juan\n    Bye, I don't have time for this.\n", example.call
  end

  test "conditional operation" do
    template = (<<-EOT).gsub(/ {4}/, "")
    % if true
      I'll display to you
    % else
      I won't display, sorry
    % end
    EOT

    example = Ate.parse(template)
    assert_equal "  I'll display to you\n", example.call
  end

  test "loop operation" do
    template = (<<-EOT).gsub(/ {4}/, "")
    % 3.times do
      Beetlejuice
    % end
    EOT

    example = Ate.parse(template)
    assert_equal "  Beetlejuice\n  Beetlejuice\n  Beetlejuice\n", example.call
  end

  test "loading a file" do
    assert_equal "  Beetlejuice\n  Beetlejuice\n  Beetlejuice\n", Ate.parse("test/example.ate").call
  end
end