require 'ap'
require 'pact/consumer/rspec'

RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app NewPadrino1::App
#   app NewPadrino1::App.tap { |a| }
#   app(NewPadrino1::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end

Pact.service_consumer "My Consumer" do
  has_pact_with "My Provider" do
    mock_service :my_provider do
      port 1234
    end
  end
end
