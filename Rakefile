require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rubocop/rake_task'
require 'yard'
RSpec::Core::RakeTask.new(:spec)

task default: [:rubocop, :spec]

desc 'Run rubocop'
RuboCop::RakeTask.new

desc 'Build documentation'
YARD::Rake::YardocTask.new
