Ate
====

Inspired by [mote][1], Ate is a minimalist framework-agnostic template engine.

## Introduction

Template engines are things of all days. And this days most of them have several hundred (erb) if not thousand (erubis) of lines of code, even slim isn't so slim. So, Ate was written with the requirements of be simple and easy to use.

## Installation

Installing Ate is as simple as running:

```
$ gem install ate
```

Include Ate in your Gemfile with gem 'ate' or require it with require 'ate'.

Usage
-----

Is very similar than other template engines for Ruby as Liquid, Mote, etc:

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

As this is ruby code, you can comment as you has always done.

```
% # I'm a comment.
```

And you can still doing any ruby thing: blocks, loops, etc.

```
% 3.times do |i|
  {{i}}
% end
```

## Variables

To print a variable just use `{{` and `}}`

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

You can even take advantage of do whatever operation inside the `{{ }}`

```ruby
template = Ate.parse("The new price is: {{ price + 10 }}", price: 30)
template.render #=> "The new price is: 40"
```

## Contexts

For send a particular context to your template, use the key `context` and your methods and variables will be called inside of your sent context.

```ruby
class User
  def name
    "Julio"
  end
end

template = Ate.parse("Hi, I'm {{ name }}", context: User.new)
template.render #=> "Hi, I'm Julio"
```

## Templates

In order to use Ate in a file template, use the suffix `.ate`, e.g. `public/index.html.ate` and add the path of your view in the parse method. Feel free to use any markup language as HTML.

```html
<!-- public/index.html.ate -->
<body>
  <h1>{{ main_title }}</h1>
  % posts.each do |post|
    <article>...</article>
  % end
</body>
```

```ruby
template = Ate.parse("public/index.html.ate", main_title: "h1 title!", posts: array_of_posts)
```

[1]: https://github.com/soveran/mote