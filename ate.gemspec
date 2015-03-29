require "./lib/ate"

Gem::Specification.new do |s|
  s.name              = "ate"
  s.version           = Ate::VERSION
  s.summary           = "Atractive Template Engine for minimalist people."
  s.description       = "Ate is a minimalist and fast template engine."
  s.authors           = ["Julio Lopez"]
  s.email             = ["ljuliom@gmail.com"]
  s.homepage          = "https://github.com/TheBlasfem/ate"
  s.files = Dir[
    "LICENSE",
    "README.md",
    "lib/**/*.rb",
    "*.gemspec",
    "test/**/*.rb"
  ]
  s.license           = "MIT"
  s.add_development_dependency "cutest"
end