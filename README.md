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

## Ruby code

Lines that start with `%` are evaluated as Ruby code.

```
% if true
  Hi
% else
  No, I won't display me
% end
```

As this is ruby code, you can comment as you has always done

```
% # I'm a comment.
```

And you can still doing any ruby thing: blocks, loops, etc.

```
% 3.times do |i|
  {{i}}
% end
```

## Assignment

To print a variable just use `{{` and `}}`

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
parsed.render #=> "a\nb\n\c"
```

You can even take advantage of do whatever operation inside the brackets

```ruby
template = Ate.parse("The new price is: {{ price + 10 }}", price: 30)
template.render #=> "The new price is: 40"
```

## Contexts

For send a particular context to your template, use the context key

```ruby
user = User.new "Julio"
puts user.name #=> "Julio"
template = Ate.parse("Hi, I'm {{ context.name }}", context: user)
template.render #=> "Hi, I'm Julio"
```

## Using files

Declare you file with .ate extension in the parse method

```ruby
template = Ate.parse("example.ate")
```