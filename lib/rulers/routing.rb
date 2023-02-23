module Rulers
  class ControllerMissingError < StandardError; end
end

def get_controller_and_action(env)
  _, cont, action, after = env["PATH_INFO"].split('/', 4)

  begin
    klass = Object.const_get("#{cont.capitalize}Controller")
    [klass, action]
  rescue NameError
    raise Rulers::ControllerMissingError, "No controller present for path #{ cont }"
  end
end
