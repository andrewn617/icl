require 'rake/clean'
require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubygems'
require 'rubygems/package_task'

spec = eval(File.read('icl.gemspec'))

task :default => [:test,:features]
