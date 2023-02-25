module Rulers
  class ControllerMissingError < StandardError; end

  class Application
    def get_controller_and_action(env)
      _, cont, action, after = env["PATH_INFO"].split('/', 4)

      begin
        controller_name = "#{cont.capitalize}Controller"

        klass = Object.const_get(controller_name)
        [klass, action]
      rescue NameError
        raise Rulers::ControllerMissingError, "No controller present for path #{ cont }"
      end
    end
  end
end
