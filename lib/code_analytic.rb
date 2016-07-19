# frozen_string_literal: true
require 'code_analytic/version'
require 'rubocop'
require 'active_support/all'

module CodeAnalytic
  require 'code_analytic/parser/ruby'
  require 'code_analytic/stat_builder/averaging'
  require 'code_analytic/stat_builder/base'
  require 'code_analytic/stat_builder/ruby'
end
