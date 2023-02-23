class Object
  def self.const_missing(name)
    puts [name, Rulers.to_underscore(name.to_s)].join("\n")
    require Rulers.to_underscore(name.to_s)
    const_get name
  end
end
