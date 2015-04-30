require "bundler/setup"

require 'rails'
require 'action_controller'
require 'action_controller/test_case'
require "active_support/json"
require 'minitest/autorun'
# Ensure backward compatibility with Minitest 4
Minitest::Test = MiniTest::Unit::TestCase unless defined?(Minitest::Test)

require "legacy_serializer"

require 'fixtures/poro'

module TestHelper
  Routes = ActionDispatch::Routing::RouteSet.new
  Routes.draw do
    get ':controller(/:action(/:id))'
    get ':controller(/:action)'
  end

  ActionController::Base.send :include, Routes.url_helpers
end

ActionController::TestCase.class_eval do
  def setup
    @routes = TestHelper::Routes
  end
end

def def_serializer(&block)
  Class.new(LegacySerializer::Serializer, &block)
end
