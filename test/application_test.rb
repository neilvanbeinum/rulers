require_relative "test_helper"

class TestController < Rulers::Controller
  def index
    @greeting = "yo"
    render :view
  end

  def view_template
    <<~TEMPLATE
      Hello here is the variable: #{ @greeting }
      And the gem version: #{ gem_version }
    TEMPLATE
  end
end

class TestApp < Rulers::Application
  def get_controller_and_action(env)
    [TestController, "index"]
  end
end

class ApplicationTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_response
    get "/"

    assert_equal "text/html", last_response.content_type
    assert last_response.ok?
    assert last_response.body.include? "Hello here is the variable: yo"
    assert last_response.body.include? "And the gem version: #{Rulers::VERSION}"
  end
end
