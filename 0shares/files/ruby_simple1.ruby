# -*- coding: utf-8 -*-
class Gordon
  attr_accessor :names     # 让g.name可以使用
  def initialize(name="gordon")
    @name = name
  end
  def hi
    puts "hi #{@name}"
  end

end


g= Gordon.new
g.hi   # hi gordon
h = Gordon.new("David")
h.hi    # hi David

g.name = "miya"
g.hi    # hi miya
puts "hi #{g.name}"    # hi miya



