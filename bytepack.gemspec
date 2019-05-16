require File.expand_path("../lib/bytepack/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "bytepack"
  s.version     = Bytepack::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Valery Kvon"]
  s.email       = 'addagger@gmail.com'
  s.date        = '2019-05-16'
  s.homepage    = "https://github.com/addagger/bytepack"
  s.summary     = "Tool for byte-serialization of various Ruby data structures"
  s.description = "Packing & unpacking various Ruby data to/from a byte string, incl. arrays, hashes and custom data structures"
  s.required_ruby_version = '>= 2.4.0'
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "bytepack"

  # If you have other dependencies, add them here
  s.add_dependency "minitest", "~> 5.11"
  s.files        = Dir["{lib}/**/*.rb", "LICENSE", "*.md"]
  s.require_path = 'lib'
  s.license      = 'MIT'
end