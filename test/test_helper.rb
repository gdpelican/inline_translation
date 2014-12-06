ENV['RAILS_ENV'] = 'test'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'byebug'
require 'bundler/setup'
require 'active_record'
require 'temping'
ActiveRecord::Base.establish_connection adapter: :sqlite3, database: ':memory:'

require 'action_controller'

require 'fixtures/rails'
require 'fixtures/application_controller'

require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'
require 'rails/test_help'

require 'test_types/unit_test'
require 'test_types/controller_test'
require 'test_types/integration_test'

require 'babbel'

I18n.enforce_available_locales = false

def setup_destination
  destination File.expand_path '../../../tmp', __FILE__
  setup :prepare_destination
end

def setup_model(model = :test_model)
  constantized = model.to_s.split("_").collect(&:capitalize).join
  unless Object.const_defined?(constantized)
    Temping.create model do 
      with_columns do |t| 
        t.integer :id_alt
        t.string :column1, :column2, :language, :language_alt 
      end
    end
    include_acts_as_translatable Object.const_get(constantized)
  end
end

def setup_translation
  unless Object.const_defined?("Translation")
    Temping.create :translation do
      with_columns do |t|
        t.integer :translatable_id
        t.string  :translatable_type
        t.string  :field
        t.string  :language
        t.text    :translation
        t.timestamps
      end
    end
  end
end

def setup_bing_translator_env
  ENV['BING_TRANSLATOR_APP_ID'] = 'set'
  ENV['BING_TRANSLATOR_SECRET'] = 'set'
end

def include_acts_as_translatable(model)
  model.class_eval "include Babbel::Concerns::ActsAsTranslatable"
end

def include_translatable(model)
  model.class_eval "include Babbel::Concerns::Translatable"
end