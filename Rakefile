# frozen_string_literal: true
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

import File.join(File.dirname(__FILE__), 'lib/tasks', 'analitic_build.rake')
