module Babbel
  VERSION = "0.0.1"

  def self.translator=(translator)
    @@translator = translator
  end

  def self.translator
    @@translator
  end
end