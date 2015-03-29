Ate
====

Atractive Template Engine for minimalist people

## Introduction

Template engines are things of all days. This days most of them have several hundred (erb) if not thousand (erubis) of lines of code, even slim isn't so slim. So, Ate was written with the requirements of be simple and easy to use.

## Installation

Installing Ate is as simple as running:

```
$ gem install ate
```

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

For send a particular context to your template, use the context key

```ruby
user = User.new "Julio"
puts user.name #=> "Julio"
template = Ate.parse("Hi, I'm {{ context.name }}", context: user)
template.render #=> "Hi, I'm Julio"
```

## Using files

In order to use Ate for a view, use the suffix `.ate`, e.g. `public/index.html.ate` and add the route of your file in the parse method. Feel free to use any markup language as HTML

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