module Rails
  def self.application
    OpenStruct.new routes: routes,
                   env_config: {}
  end

  def self.root
    Dir['../../../']
  end

  def self.env
    OpenStruct.new to_s: "test",
                   development?: false,
                   test?: true,
                   production?: false
  end

  def self.backtrace_cleaner
    ActiveSupport::BacktraceCleaner.new
  end

  class Engine
  end

  private

  def self.routes
    @routes ||= ActionDispatch::Routing::RouteSet.new.tap do |routes|
      routes.draw { resources :translations }
    end
  end

  def self.draw_routes

  end
end