# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crystal/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "crystal-rails"
  spec.version       = Crystal::Rails::VERSION
  spec.authors       = ["Michail"]
  spec.email         = ["xbiznet@gmail.com"]

  spec.summary       = %q{Crystal framework for the Rails asset pipeline.}
  spec.description   = %q{Crystal framework for the Rails asset pipeline.}
  spec.homepage      = "https://github.com/madmike/crystal-rails."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files`.split("\n").reject { |f| f =~ /^testapp|^jquery-ui/ }
  spec.require_paths = ["lib"]
  
  # get an array of submodule dirs by executing 'pwd' inside each submodule
  gem_dir = File.expand_path(File.dirname(__FILE__)) + "/"
  `git submodule --quiet foreach pwd`.split($\).each do |submodule_path|
    Dir.chdir(submodule_path) do
      submodule_relative_path = submodule_path.sub gem_dir, ""
      # issue git ls-files in submodule's directory and
      # prepend the submodule path to create absolute file paths
      `git ls-files`.split($\).each do |filename|
        spec.files << "#{submodule_relative_path}/#{filename}"
      end
    end
  end
end
