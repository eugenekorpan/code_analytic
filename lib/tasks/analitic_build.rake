# frozen_string_literal: true
require 'code_analytic'

namespace :analitic do
  desc 'run analitic builder'
  task :build, [:path] do |_, args|
    puts CodeAnalytic::StatBuilder::Base.for(args.path).build
  end
end
