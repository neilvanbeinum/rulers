# frozen_string_literal: true

require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        [404, {'Content-Type' => 'text/html'}, ['No']]
      elsif env['PATH_INFO'] == "/"
        puts `ls`

        index_file_path = File.expand_path('../../public/index.html', __FILE__)

        text = File.readlines(index_file_path)

        [302, { 'Location' => '/quotes/get' }, [] ]
      else
        klass, act = get_controller_and_action(env)
        puts "klass: #{klass}"
        controller = klass.new(env)

        begin
          text = controller.send(act)
          [200, {'Content-Type' => 'text/html'}, [text]]
        rescue StandardError => e
          puts "Error! #{ e.message }"
          [500, { 'Content-Type' => 'text/html' }, ["That's an error"]]
        end

        # [200, {'Content-Type' => 'text/html'}, ["Hello from Ruby on Rulers!"]]
      end
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end
