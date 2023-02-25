class Object
  def self.const_missing(name)
    # Require is relative to the working directory
    # In this context it will mean loading from your application
    # (not the framework)
    require Rulers.to_underscore(name.to_s)
    const_get name
  end
end
