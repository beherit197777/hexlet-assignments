require_relative "lib/blog/version"

require_relative "lib/blog/version"

Gem::Specification.new do |spec|
  spec.name        = "blog"
  spec.version     = Blog::VERSION
  spec.authors     = [ "beherit197777" ]
  spec.email       = [ "beherit197777@gmail.com" ]
  spec.homepage    = "https://example.com" # Замените на ваш URL
  spec.summary     = "A simple blog engine for Rails."
  spec.description = "This engine provides blogging functionality for Rails applications."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/beherit197777/blog"
  spec.metadata["changelog_uri"] = "https://github.com/beherit197777/blog/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", "~> 7.0"
end
