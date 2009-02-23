module LazyAttr
  def lazy_attr_reader(method_name, default_value)
    ivar_name = "@#{method_name}"

    define_method method_name do
      if ivar = instance_variable_get(ivar_name)
        ivar
      else
        instance_variable_set(ivar_name, default_value.call)
      end
    end
  end

  def lazy_attr_accessor(method_name, default_value)
    lazy_attr_reader(method_name, default_value)
    attr_writer(method_name)
  end
end
