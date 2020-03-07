#
#Example of using splat and double splat methods of handling arguments.
# *args will become an array 
# *keyword_args will become a set of keys in a hash, similar to doing a: params = {}
#
def kargs (*args, **keyword_args)
  {args: args, keyword_args: keyword_args}
end                
=> :kargs
r = kargs 1,"a","b",{subscription: {"endpoint":"https://updates.push.services.mozilla.com/wpush/v2/gAAAAABdxtrFHNIFHYYEKSQdO0dG40SBLeT1CC3i7fRbkrBfoCkTHcX8zOm4_PS-nw3E8H59RtkCtM4atfMSuhExJvLhQX3bf-VCnC1J4qj7RWA-lwL3e3WYR0k8eiCwgs-huLyPHObHLuZY2i6cZvRKp0lIw30LSUCN3_U7L9WYvDK6-8BIuRo","keys":{"auth":"h1tpvUgEphIj74uq21P5MQ","p256dh":"BJLW-XjQKONatSWmkZ0KIephuVYlvCvtLPapXH9hqk8WazIASnbPI0jpnqJZVZiPY-ZcKjXfTuw08PnX2dqccHQ"}} , title: "How I won the War" }

#Here are the results
=> {:args=>[1, "a", "b"],
 :keyword_args=>
  {:subscription=>
    {:endpoint=>
      "https://updates.push.services.mozilla.com/wpush/v2/gAAAAABdxtrFHNIFHYYEKSQdO0dG40SBLeT1CC3i7fRbkrBfoCkTHcX8zOm4_PS-nw3E8H59RtkCtM4atfMSuhExJvLhQX3bf-VCnC1J4qj7RWA-lwL3e3WYR0k8eiCwgs-huLyPHObHLuZY2i6cZvRKp0lIw30LSUCN3_U7L9WYvDK6-8BIuRo",
     :keys=>
      {:auth=>"h1tpvUgEphIj74uq21P5MQ",
       :p256dh=>"BJLW-XjQKONatSWmkZ0KIephuVYlvCvtLPapXH9hqk8WazIASnbPI0jpnqJZVZiPY-ZcKjXfTuw08PnX2dqccHQ"}},
   :title=>"How I won the War"}}


#
#An example of how self behaves when including a module in a class
#The module will become a superclass of the including class
#if the module method is defined with self, it is a singleton method
#for the module and not accessible from the class unless scoped with the module name. It then retains 
#its module self-identity
#

#! /home/whodabudda/.rvm/rubies/ruby-2.6.1/bin/ruby 

module M1

def self.desc_self
   p "in M1.desc_self self: #{self}"
end
def call_desc_self
  M1.desc_self
end
desc_self
end

class C
 include M1
 def initialize
   p "in C.initialize self: #{self}"
   M1.desc_self
   call_desc_self
  end
  def self.iam_a_class_method
   p "in C.iam_a_class_method self: #{self}"
  end
end 
C.iam_a_class_method
c = C.new
p C.methods(false)
p c.methods(false)
p C.ancestors
p c.ancestors
exit

class A
 attr_accessor :interactor
 def create
   p "in A.create self: #{self}"
   interactor = B.call(self)
   p "in A.create interactor: #{interactor}"
 end
end

class B
 attr_accessor :interactor, :context
 def initialize(context)
   @context = context
 end
 def self.call(context)
   p "in B.call context: #{context}"
   interactor = new(context)
   p "in B.call interactor: #{interactor}"
   interactor.run
   interactor
 end
 def run
   p "in B #{self}.run"
 end
end

A.new.create


