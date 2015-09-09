lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'server_tools/version'

Gem::Specification.new do |spec|
  spec.name          = "server_tools"
  spec.version       = ServerTools::VERSION
  spec.authors       = ["Decomplect Software LLP"]
  spec.email         = ["hello@decomplect.io"]

  spec.summary       = %(A bunch of tools to provision (via Chef) and deploy packages to servers)
  spec.homepage      = "https://github.com/decomplect-io/server_tools"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop", "~> 0.3"
  spec.add_development_dependency "yard", "~> 0.8"
  spec.add_development_dependency "redcarpet", "~> 3.3"

  spec.add_dependency "chef", "~> 12.3"
  spec.add_dependency "thor", "~> 0.19"
end
