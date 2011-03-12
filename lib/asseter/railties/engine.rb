module Asseter
  module Railties
    class Engine < Rails::Engine
      initializer "my_engine.add_middleware" do |app|
        app.middleware.use Asseter::Middleware, {
          :cache => Rails.env.production?
        }
      end
    end
  end
end
