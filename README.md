Ate
====

Atractive Template Engine for minimalist people

## Installation

You can install it by rubygems.

```
$ gem install ate
```

Usage
-----

Very similar than other template engines for Ruby:

```ruby
template = Ate.parse("Hello World")
template.render #=> "Hello World"
```

## Control flow

Lines that start with `%` are evaluated as Ruby code.

```
% if true
% else
% end
```

As this is ruby code, you can comment as you has always done

```
% # I'm a comment.
```

## Assignment

To print a variable just use `{{` and `}}`


## Block evaluation

```
% 3.times do |i|
  {{i}}
% end
```

## Send Variables

Send a variables as a hash in the parse method to the template so it can get them:

```ruby
template = Ate.parse("Hello, this is {{user}}", user: "dog")
template.render #=> "Hello, this is dog"
```

Also, you can send other kinds of variables:

```ruby
template = <<-EOT
  % items.each do |item|
    {{ item }}
  % end
EOT
parsed = Ate.parse(template, items: ["a", "b", "c"])
parsed.render #=> "a\nb\n\c\n"
```

## Contexts

You can even send a particular context to your template using the context key

```ruby
user = User.new "Julio"
puts user.name #=> "Julio"
template = Ate.parse("Hi, I'm {{ context.name }}", context: user)
template.render #=> "Hi, I'm Julio"
```

## Using files

Definitely, you can use any file with .ate extension

```ruby
template = Ate.parse("example.ate")
```