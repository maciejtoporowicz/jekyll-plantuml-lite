Gem::Specification.new do |s|
    s.name        = "jekyll-plantuml-lite"
    s.version     = "0.0.2"
    s.summary     = "Generated PlantUML diagrams in Jekyll"
    s.description = "Generating PlantUML diagrams in Jekyll using a PlantUML server."
    s.authors     = ["Maciej Toporowicz"]
    s.email       = "maciej@toporowicz.it"
    s.files       = `git ls-files | grep lib/`.split("\n")
    s.homepage    =
      "https://github.com/maciejtoporowicz/jekyll-plantuml-lite"
    s.license       = "MIT"
    s.metadata    = { "source_code_uri" => "https://github.com/maciejtoporowicz/jekyll-plantuml-lite" }
  end