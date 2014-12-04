# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'has_many_commas/version'

Gem::Specification.new do |spec|
  spec.name          = "has_many_commas"
  spec.version       = HasManyCommas::VERSION
  spec.authors       = ["Yoshiki Schmitz"]
  spec.email         = ["yoshikischmitz@outlook.com"]
  spec.summary       = %q{A ruby gem for writing active_record has_many query results to tabular flat-files like CSV.}
  spec.description   = %q{Takes active_record queries, along with a symbol associated to a has_many association, and gives a tabular representation of each parent record row along with all of its child records appended as extra columns. If you have a user model, that has many comments, you'll get a file with one row per user, with each user's comments appearing in additional columns, like: "user_comment_1", "user_comment_2", "user_comment_3"}
  spec.homepage      = "https://github.com/Takemikazuchi/has_many_commas"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
