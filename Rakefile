require "bundler/gem_tasks"
require 'rubocop/rake_task'
require 'yard'

task default: [:rubocop]

desc 'Run rubocop'
RuboCop::RakeTask.new

desc 'Build documentation'
YARD::Rake::YardocTask.new
