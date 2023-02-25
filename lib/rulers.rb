# frozen_string_literal: true

require "rulers/version"
require "rulers/util"
require "rulers/dependencies"
require "rulers/routing"
require "rulers/controller"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        [404, {'Content-Type' => 'text/html'}, ['No']]
      else
        klass, act = get_controller_and_action(env)
        controller = klass.new(env)

        begin
          text = controller.send(act)

          [200, {'Content-Type' => 'text/html'}, [text || ""]]
        rescue StandardError => e
          [500, { 'Content-Type' => 'text/html' }, ["That's an error"]]
        end
      end
    end
  end
end
