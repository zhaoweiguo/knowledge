ruby使用
####################


::

    puts <str>
    print <str>



::

    <str>.chop
    <str>.gsub


ruby注释::

    # <comment>

    =begin
    <comment>
    =end

::

    a = %w{ ant bee cat dog elk }

    instSection = {
      'cello'     => 'string',
      'clarinet'  => 'woodwind'
    }


控制结构::

    if count > 10
      puts "Try again"
    elsif tries == 3
      puts "You lose"
    else
      puts "Enter a number"
    end


    // while与if都有简写形式
    while numPallets <= 30
      numPallets += 1
    end

    if radiation > 3000
      puts "Danger, Will Robinson"
    end
    //等同于
    puts "Danger, Will Robinson" if radiation > 3000


case语句::

    ruby> i=8
    ruby> case i
      | when 1, 2..5
      |   puts "1..5"
      | when 6..10
      |   puts "6..10"
      | end
    6..10
      nil

for语句::

    ruby> for num in (4..6)
      |    puts num
      | end

loop语句::

    loop do
       <do something> unless gordon.isrich?
       break if gordon.isrich?
    end


Array语句::

    []    # 同Array.new
    a=[1, 2, 3]   # 下面每次a的值改变后,默认于还原回来

    a << "gordon"      # a=[1, 2, 3, "gordon"]
    a.push("gordon")   # 同上

    a.map {|i| i + 1 }  # a=[2, 3, 4]   (transforming arrays)
    a.select {|number| number % 2 == 0}   # 返回值[2],  a=[2, 4, 6] (filtering arrays)
    a.delete(3)     # 返回值3, a=[1, 2]
    a.delete_if{ |x| x<3}  # a=[3]
