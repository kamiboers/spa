ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'minitest/autorun'
require 'minitest/pride'

Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  # Helper methods to be used by all tests
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  DatabaseCleaner.strategy = :truncation
  self.use_transactional_tests = false

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def json_response
    JSON.parse response.body
  end

  def use_javascript
    Capybara.current_driver = Capybara.javascript_driver
  end

  def reset_driver
    Capybara.current_driver = nil
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def wait_for_delay
    sleep 1
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

end
