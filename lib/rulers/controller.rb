require "erubis"
require 'rulers/helpers'
require 'rulers/file_model'

module Rulers
  class Controller
    include Rulers::Helpers
    include Rulers::Model

    attr_reader :env

    def initialize(env)
      @env = env
    end

    def view_directory
      Rulers.to_underscore(self.class.to_s.delete_suffix("Controller"))
    end

    def view_file(view)
      # Assumes the app is being run from the root directory
      File.join("views", view_directory, "#{view}.html.erb")
    end

    def view_template(view)
      File.read(view_file(view))
    end

    def render(view, locals = {})
      erb_template = Erubis::Eruby.new(view_template(view))

      erb_template.result(binding)
    end
  end
end
