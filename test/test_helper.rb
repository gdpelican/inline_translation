ENV['RAILS_ENV'] = 'test'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'bundler/setup'
require 'minitest/autorun'
require 'rails/generators/test_case'

require 'babbel'
require 'babbel/generators/install/install_generator'

def setup_destination
  destination File.expand_path '../../tmp', __FILE__
  setup :prepare_destination
end