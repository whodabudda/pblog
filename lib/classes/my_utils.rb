module MyUtils

  def set_hash_accessors(data = {})
    data.each_pair do |key, value|
      instance_variable_set("@#{key}", value)
      self.class.instance_eval { attr_accessor key.to_sym }
    end
  end
end