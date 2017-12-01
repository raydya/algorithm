class Drinks
  attr_accessor :print

  def initialize
    self.print = true
  end

  def drink!(num, empty_bottles)
    if num.zero?
      sys_prints 'no bottles to drink... good bye!'
      return 0
    end
    sys_prints "start drinking #{num} bottles..."
    empty_bottles += num
    sys_prints "we got #{empty_bottles} to exchange!"
    extra_drinks = 0
    if empty_bottles >= 2
      extra_drinks = empty_bottles / 2
      sys_prints "we exchanges #{extra_drinks} extra drinks..."
      tmp_empty_bottles = empty_bottles % 2
      sys_prints "we got #{tmp_empty_bottles} empty drinks..."
    end
    num + drink!(extra_drinks, tmp_empty_bottles)
  end

  def sys_prints(str)
    puts str.inspect if print
  end

  def no_print!
    self.print = false
  end
end

# drink = Drinks.new
# drink.no_print!
# total_drinked = drink.drink!(ARGV.first.to_i, 0)
# puts total_drinked.inspect

def slow_drinks(num)
  drinked = 0
  bottle = 0
  drinks = num
  while drinks > 0
    drinks -= 1
    drinked += 1
    bottle += 1
    if bottle == 2
      drinks += 1
      bottle = 0
    end
  end
  puts "total drinked #{drinked} drinks"
  puts "left #{bottle} bottle"
end

def quick_drinks(num)
  drinked = 0
  bottle = 0
  drinks = num
  while drinks > 0
    drinked += drinks
    bottle += drinks
    drinks = bottle / 2
    bottle = bottle % 2
  end
  puts "total drinked #{drinked} drinks"
  puts "left #{bottle} bottle"
end

slow_drinks(ARGV.first.to_i)
quick_drinks(ARGV.first.to_i)
