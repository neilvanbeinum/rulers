require "erubis"
require 'rulers/helpers'

module Rulers
  class Controller
    include Rulers::Helpers

    attr_reader :env

    def initialize(env)
      @env = env
    end

    def view_directory
      Rulers.to_underscore(self.class.to_s.delete_suffix("Controller"))
    end

    def view_file
      File.join("app", "views", view_directory, "#{view_name}.html.erb")
    end

    def view_template
      File.read(view_file)
    end

    def render(view_name, locals = {})
      erb_template = Erubis::Eruby.new(view_template)

      erb_template.result(binding)
    end
  end
end
