
LazyAttr
========

Extend your class with LazyAttr:

    require "rubygems"
    require "lazy_attr"
   
    class MyClass
      extend LazyAttr
    
      lazy_attr_reader :foo, lambda { 17 }
      attr_writer :foo
    
      lazy_attr_accessor :bar, lambda { Time.now }
    end


Use it like a typical `attr_reader` or `attr_accessor`:

    >> obj = MyClass.new
    => #<MyClass:0x260818>
    
    >> obj.foo
    => 17
    >> obj.foo = 18
    => 18
    >> obj.foo
    => 18
    
    >> obj.bar
    => Mon Feb 23 01:41:15 -0500 2009
    >> obj.bar
    => Mon Feb 23 01:41:15 -0500 2009
    >> obj.bar = Time.now
    => Mon Feb 23 01:41:20 -0500 2009
    >> obj.bar
    => Mon Feb 23 01:41:20 -0500 2009



Scott Taylor // scott@railsnewbie.com
