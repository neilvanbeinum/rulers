class Array
  def deep_empty?
    empty? || all?(&:empty?)
  end
end
