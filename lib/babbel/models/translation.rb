module Babbel
  class Translation < ActiveRecord::Base
    belongs_to :translatable, polymorphic: true
    scope :to_language, ->(language) { where language: language }
    validates_presence_of :translatable, :language
  end
end
