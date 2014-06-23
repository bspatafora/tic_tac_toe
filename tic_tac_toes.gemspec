# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tic_tac_toes/version'

Gem::Specification.new do |spec|
  spec.name          = "tic_tac_toes"
  spec.version       = TicTacToes::VERSION
  spec.authors       = ["Ben Spatafora"]
  spec.email         = ["benjamin.spatafora@gmail.com"]
  spec.summary       = %q{The game Tic-tac-toe, featuring an unbeatable AI}
  spec.homepage      = "http://github.com/bspatafora/tic_tac_toes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["tic_tac_toes", "set_up_ttt_databases", "destroy_ttt_databases"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_dependency "pg"
end
