# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'torrent_search/version'

Gem::Specification.new do |spec|
  spec.name          = "torrent_search"
  spec.version       = TorrentSearch::VERSION
  spec.authors       = ["Jon Neverland"]
  spec.email         = ["jonwestin@gmail.com"]
  spec.description   = %q{Search various torrent sites}
  spec.summary       = %q{Search various torrent sites}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "~> 0.18"
  spec.add_runtime_dependency "mechanize", "~> 2.7.3"


  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
