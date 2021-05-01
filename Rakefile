require "rubygems"
require "rake/testtask"
task default: :test

Rake::TestTask.new do |task|
  task.pattern = "test/*_test.rb"
end

task :build do
  `rm qr4r-*.gem`
  puts `gem build qr4r.gemspec`
end

task release: :build do
  puts `gem push qr4r-*.gem`
end
