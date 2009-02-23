require File.dirname(__FILE__) + "/spec_helper"

describe LazyAttr do
  def new_class(&block)
    klass = Class.new do
      extend LazyAttr
    end
    klass.class_eval(&block)
    klass
  end

  describe "lazy attr reader" do
    it "should define a lazy attr reader which sets the value on access" do
      klass = new_class do
        lazy_attr_reader :foo, lambda { [] }
      end

      klass.new.foo.should == []
    end

    it "should use the correct value for the reader" do
      klass = new_class do
        lazy_attr_reader :foo, lambda { "foobar" }
      end

      klass.new.foo.should == "foobar"
    end

    it "should use the real value if given" do
      klass = new_class do
        lazy_attr_reader :foo, lambda { "foobar" }
        attr_writer :foo
      end

      obj = klass.new

      obj.foo = "bar"
      obj.foo.should == "bar"
    end

    it "should set the ivar on the first access" do
      klass = new_class do
        lazy_attr_reader :foo, lambda { "foobar" }
      end

      obj = klass.new

      obj.foo
      obj.instance_variable_get("@foo").should == "foobar"
    end

    it "should use the correct name for the accessor" do
      klass = new_class do
        lazy_attr_reader :bar, lambda { "foobar" }
      end

      obj = klass.new

      obj.should respond_to(:bar)
    end
  end

  describe "lazy_attr_accessor" do
    it "should setup a normal writer" do
      klass = new_class do
        lazy_attr_accessor :foo, lambda { nil }
      end

      obj = klass.new

      obj.foo = "bar"
      obj.foo.should == "bar"
    end

    it "should setup a lazy_attr_reader" do
      klass = new_class do
        lazy_attr_accessor :foo, lambda { "baz" }
      end

      obj = klass.new
      obj.foo.should == "baz"
    end

    it "should setup a reader & writer with the correct names" do
      klass = new_class do
        lazy_attr_accessor :baz, lambda { "baz" }
      end

      obj = klass.new
      obj.should respond_to(:baz)
      obj.should respond_to(:baz=)
    end

    it "should use the default value given" do
      an_object = mock 'an object'

      klass = new_class do
        lazy_attr_accessor :baz, lambda { an_object }
      end

      obj = klass.new
      obj.baz.should equal(an_object)
    end
  end
end
