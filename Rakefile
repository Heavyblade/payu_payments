#!/usr/bin/env rake
$LOAD_PATH << File.expand_path("../lib", __FILE__)
Dir.chdir(File.expand_path("..", __FILE__))

require 'payu_payments'
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

desc "Payupayments console"
task :console do
  require 'irb'
  require 'irb/completion'
  require 'payu_payments'
  require 'pry'

  ARGV.clear
  IRB.start
end


# If you want to make this the default task
task :default => :spec
