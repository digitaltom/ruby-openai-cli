require_relative "lib/version"

Gem::Specification.new do |s|
  s.name        = "ruby-openai-cli"
  s.version     = VERSION
  s.summary     = "CLI interface for OpenAI ChatGPT"
  s.description = "Using ChatGPT from the command line."
  s.homepage    = "https://github.com/digitaltom/ruby-openai-cli"
  s.license     = "MIT"
  s.authors     = ["Thomas Schmidt"]
  s.email       = "tom@digitalflow.de"
  s.files       = Dir['{bin,lib}/**/*', 'README*', 'LICENSE*']
  s.executables << 'ruby-openai-cli'
  s.require_paths = ["lib"]

  s.add_dependency "ruby-openai", "~> 3.7"
  #s.add_dependency "dotenv", "~> 2.8" # already pulled in by ruby-openai
  s.add_dependency "optparse", "~> 0.3"
  s.add_dependency "tty-markdown", "~> 0.7"

  s.add_development_dependency "byebug", "~> 11.1"
  s.add_development_dependency "awesome_print", "~> 1.9"

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = s.homepage
  s.metadata["changelog_uri"] = s.homepage
end
