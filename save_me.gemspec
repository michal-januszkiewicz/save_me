# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'save_me/version'

Gem::Specification.new do |spec|
  spec.name          = "save_me"
  spec.version       = SaveMe::VERSION
  spec.authors       = ["Michał Januszkiewicz"]
  spec.email         = ["michal.januszkiewicz@monterail.com"]

  spec.summary       = %q{Save a file before you overwrite it}
  spec.description   = %q{Store your results file in a neat file structure}
  spec.homepage      = "https://github.com/michal-januszkiewicz/save_me"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "fakefs"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "json"
  spec.add_development_dependency "pry"

  spec.add_dependency "fileutils"
  spec.add_dependency "json"
end
