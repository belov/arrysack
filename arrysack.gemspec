# frozen_string_literal: true

require_relative 'lib/arrysack/version'

Gem::Specification.new do |spec|
  spec.name = 'arrysack'
  spec.version = Arrysack::VERSION
  spec.authors = ['Ilya Belov']
  spec.email = ['ibelov2@gmail.com']

  spec.summary = 'Filters for array'
  spec.description = 'Filters for array'
  spec.homepage = 'https://github.com/belov/arrysack'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.5.5'

  # spec.metadata['allowed_push_host'] = "Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/belov/arrysack'
  spec.metadata['changelog_uri'] = 'https://github.com/belov/arrysack/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .gitlab-ci.yml appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency "concurrent-ruby", '~> 1.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
