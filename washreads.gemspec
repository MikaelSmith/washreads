Gem::Specification.new do |spec|
  spec.name          = "washreads"
  spec.version       = "0.1.0"
  spec.authors       = ["Michael Smith"]

  spec.summary       = "A Wash plugin for browsing your Goodreads bookshelf"
  spec.description   = "Execute commands remotely over SSH and WinRM"
  spec.homepage      = "https://github.com/MikaelSmith/washreads"
  spec.license       = "Apache-2.0"
  spec.files         = "goodreads"
  spec.bindir        = "."
  spec.executables   << "goodreads"

  spec.required_ruby_version = "~> 2.3"

  spec.add_dependency "oauth", '~> 0.5'
  spec.add_dependency "nokogiri", "~> 1.10"
end
