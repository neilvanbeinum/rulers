require_relative "../test_helper"
require_relative "config/test_app"
require_relative "app/controllers/test_controller"
require "multi_json"

class ApplicationTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TestApp.new(root_controller: TestController)
  end

  def setup
    [
      {"quote":"quote 1","attribution":"attribution 1"},
      {"quote":"quote 2","attribution":"attribution 2"}
    ].each.with_index(1) do |quote, index|
      write_quote_file(quote, index)
    end
  end

  def dirname
    dirname ||= File.expand_path("../app/db/quotes", __FILE__)
  end

  def write_quote_file(quote, index)
    File.open(File.join(dirname, "#{index}.json"), "w") do |f|
      f.write MultiJson.dump(quote)
    end
  end

  def teardown
    Dir.glob(File.join(dirname, "*.json")).each do |f|
      File.delete f
    end
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

    assert_match Regexp.new(expected_template), last_response.body
  end

  def test_model_show
    get "/quotes/show?id=2"

    assert last_response.body.include? "<p>Quote: quote 2</p>"
    assert last_response.body.include? "<p>Attribution: attribution 2</p>"
  end

  def test_quote_update
    post "/quotes/update", "quote" => 'quote_1'

    assert last_response.ok?
  end
end
