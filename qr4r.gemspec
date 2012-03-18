$:.push File.expand_path("../lib", __FILE__)
require "qr4r/version"

Gem::Specification.new do |s|
  s.name        = "qr4r"
  s.version     = Qr4r::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jon Rogers"]
  s.email       = ["r@2rye.com"]
  s.homepage    = "http://github.com/2rye/qr4r"
  s.summary     = "qr4r-#{Qr4r::VERSION}"
  s.description = %q{QR PNG Generator for Ruby. Leveraging RQRCode and MojoMagick modules}

  s.rubyforge_project = "qr4r"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency('rake')
end
