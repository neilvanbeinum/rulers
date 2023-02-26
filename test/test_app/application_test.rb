require_relative "../test_helper"
require_relative "config/test_app"
require_relative "app/controllers/test_controller"

class ApplicationTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TestApp.new(root_controller: TestController)
  end

  def test_root_controller_and_view
    get "/"

    assert last_response.ok?
    assert_equal "text/html", last_response.content_type

    assert last_response.body.include? "<p>Here's the instance variable: variable</p>"
    assert last_response.body.include? "<p>And the gem version: #{Rulers::VERSION}</p>"
  end

  def test_model_controller_and_view
    get "/quotes/index"

    assert last_response.ok?
    assert_equal "text/html", last_response.content_type

    expected_template = <<~TEMPLATE
    <ol>
      <li>
        <p>Quote: quote 1</p>
        <p>Attribution: attribution 1</p>
      </li>
      <li>
        <p>Quote: quote 2</p>
        <p>Attribution: attribution 2</p>
      </li>
    </ol>
    TEMPLATE

    assert_match /#{expected_template}/, last_response.body
  end
end
