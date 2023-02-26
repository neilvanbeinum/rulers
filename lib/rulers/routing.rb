module Rulers
  module Routing
    class ControllerMissingError < StandardError; end
    class RootControllerMissingError < ControllerMissingError; end

    def get_controller_and_action(env)
      _, cont, action, _after = env["PATH_INFO"].split('/', 4)

      begin
        klass = Object.const_get(controller_name(cont, is_root: env["PATH_INFO"] == "/"))
        [klass, action]
      rescue NameError
        raise ControllerMissingError, "No controller present for path #{ cont }"
      end
    end

    def controller_name(cont, is_root: false)
      is_root ? @root_controller.to_s : "#{cont.capitalize}Controller"
    end
  end
end
