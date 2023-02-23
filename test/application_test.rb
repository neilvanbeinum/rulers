require_relative "test_helper"

class TestApp < Rulers::Application; end

class ApplicationTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_response
    get "/"

    # assert_equal "text/html", last_response.content_type
    # assert last_response.ok?
    # assert_equal "Hello from Ruby on Rulers!", last_response.body
  end
end
