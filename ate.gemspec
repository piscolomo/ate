require "./lib/ate"

Gem::Specification.new do |s|
  s.name              = "ate"
  s.version           = Ate::VERSION
  s.summary           = "Atractive Template Engine for minimalist people."
  s.description       = "Ate is a minimalist and fast template engine."
  s.authors           = ["Julio Lopez"]
  s.email             = ["ljuliom@gmail.com"]
  s.homepage          = "http://github.com/TheBlasfem/ate"
  s.files = Dir[
    "LICENSE",
    "README.md",
    "lib/**/*.rb",
    "*.gemspec",
    "test/**/*.rb"
  ]
  s.license           = "MIT"
  s.add_development_dependency "cutest", "1.1.3"
end