module Rails
  def self.application
    OpenStruct.new routes: routes
  end

  private

  def self.routes
    {}
  end
end