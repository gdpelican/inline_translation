# ApplicationController stub based on gist by themusicman
# https://gist.github.com/themusicman/3057139

class ApplicationController
  cattr_accessor :before_filters, :after_filters
  before_filters = after_filters = []

  def self.before_filter(method)
    before_filters << method
  end

  def self.after_filter(method)
    after_filters << method
  end
  
  def run(filter)
    self.class.send(filter).each { |method| send(method) }
  end
end
