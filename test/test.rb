require File.expand_path("../lib/ate", File.dirname(__FILE__))

scope do
  test "returning same number of empty lines" do
    parsed = Ate.parse("\n \n\n  \n")
    assert_equal "\n \n\n  \n", parsed.render
  end
  test "returning same number of empty lines with code" do
    parsed = Ate.parse("\n% false\n% true\n\n%true")
    assert_equal "\n\n", parsed.render
  end

  test "empty lines with conditional" do
    parsed = Ate.parse("\n% if true\n\n\n% else\n\n% end\n")
    assert_equal "\n\n\n", parsed.render
  end

  test "printing string" do
    parsed = Ate.parse("{{ \"Hello World!\" }}")
    assert_equal "Hello World!\n", parsed.render
  end

  test "comment" do
    template = (<<-EOT).gsub(/ /, "")
    Awesome
    % # i'm a comment
    ATE
    EOT

    parsed = Ate.parse(template)
    assert_equal "Awesome\nATE\n", parsed.render
  end

  test "respecting first empty spaces of lines" do
    template = "  Hi, Juan\n    Bye, I don't have time for this."
    parsed = Ate.parse(template)
    assert_equal "  Hi, Juan\n    Bye, I don't have time for this.\n", parsed.render
  end

  test "conditional operation" do
    template = (<<-EOT).gsub(/ {4}/, "")
    % if true
      I'll display to you
    % else
      I won't display, sorry
    % end
    EOT

    parsed = Ate.parse(template)
    assert_equal "  I'll display to you\n", parsed.render
  end

  test "running a block" do
    template = (<<-EOT).gsub(/ {4}/, "")
    % 3.times do
      Beetlejuice
    % end
    EOT

    parsed = Ate.parse(template)
    assert_equal "  Beetlejuice\n  Beetlejuice\n  Beetlejuice\n", parsed.render
  end

  test "int variables" do
    template = (<<-EOT).gsub(/ {4}/, "")
    % number.times {
    Pika {{type}}
    % }
    EOT

    parsed = Ate.parse(template, number: 3, type: 1000)
    number = 3
    assert_equal "Pika 1000\nPika 1000\nPika 1000\n", parsed.render
  end

  test "string variables" do
    parsed = Ate.parse("Hello {{name}}", name: "Julio")
    assert_equal "Hello Julio\n", parsed.render
  end

  test "mixing int and str variables" do
    template = (<<-EOT).gsub(/ {4}/, "")
    % n.times {
    {{ pokemon_name }}
    % }
    EOT

    parsed = Ate.parse(template, n: 3, pokemon_name: "Pikachu")
    assert_equal "Pikachu\nPikachu\nPikachu\n", parsed.render
  end

  test "recorring an array" do
    parsed = Ate.parse("% items.each do |item|\n{{item}}\n% end", items: ["a", "b", "c"])
    assert_equal "a\nb\nc\n", parsed.render 
  end

  test "loading a file" do
    assert_equal "  Beetlejuice\n  Beetlejuice\n  Beetlejuice\n", Ate.parse("test/example.ate").render
  end
end