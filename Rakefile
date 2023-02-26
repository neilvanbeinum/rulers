# frozen_string_literal: true

require "bundler/gem_tasks"
task default: %i[]

require "rake/testtask"
Rake::TestTask.new do |t|
  Dir.chdir("test/test_app/app")

  t.name = "test" # this is the default
  t.libs << "test" # load the test dir
  t.test_files = Dir['../*test*.rb']
  t.verbose = true
  t.options = "--color"
end
