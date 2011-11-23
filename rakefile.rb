require "bundler"
Bundler.setup

gemspec = eval(File.read("carpenter.gemspec"))

desc "build Carpenter #{Carpenter::VERSION} gemspec and install"
task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["carpenter.gemspec"] do
  system "gem build carpenter.gemspec"
  system "gem install carpenter-#{Carpenter::VERSION}.gem"
end

require 'rake/clean'
CLEAN.include "*.gem"

require 'rake/testtask'
Rake::TestTask.new(:units) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new 'cucumber' do |t|
  t.cucumber_opts = %w{--format progress}
end

desc "Run tests"
task :test => %w[units cucumber]

task :default => :test