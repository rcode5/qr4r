$LOAD_PATH.push File.expand_path("lib", __dir__)
require "qr4r/version"

Gem::Specification.new do |s|
  s.required_ruby_version = ">= 2.5.0"
  s.name        = "qr4r"
  s.licenses    = ["WTFPL"]
  s.version     = Qr4r::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jon Rogers"]
  s.email       = ["jon@rcode5.com"]
  s.homepage    = "http://github.com/rcode5/qr4r"
  s.summary     = "qr4r-#{Qr4r::VERSION}"
  s.description = "QR PNG Generator for Ruby. Leveraging RQRCode and MojoMagick modules"

  s.rubyforge_project = "qr4r"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency("mojo_magick", "~> 0.6.5")
  s.add_dependency("rqrcode_core", "~> 0.1")
  s.add_development_dependency("minitest", "~> 5.14")
  s.add_development_dependency("rake", "~> 13.0")
  s.add_development_dependency("rubocop", "~> 0.93")
  s.add_development_dependency("rubocop-performance", "~> 1.8")
end
