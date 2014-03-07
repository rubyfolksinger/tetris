# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tetris/game'
require 'tetris/gameboard'
require 'tetris/robot'
require 'tetris/tetrimino'
require 'tetris/version'

Gem::Specification.new do |spec|
  spec.name          = "tetris"
  spec.version       = Tetris::VERSION
  spec.authors       = ["Dan Tripp"]
  spec.email         = ["rubyfolksinger@gmail.com"]
  spec.description   = %q{A minimal Tetris}
  spec.summary       = %q{A very minimal Tetris for a code challenge.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-mocks"
  spec.add_development_dependency "rr"
  spec.add_development_dependency "pry"
end
