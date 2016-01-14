# swap str characters by index
def swap_chr_at_index str, from_index, to_index
  from_str = str[from_index]
  to_str = str[to_index]
  str[from_index] = to_str
  str[to_index] = from_str
  str
end

# def plane
STATIC_PLANE = 4

def swap str, from_row, from_col, to_row, to_col
  from_index = from_row*STATIC_PLANE + from_col
  to_index = to_row*STATIC_PLANE + to_col
  swap_chr_at_index str.clone, from_index, to_index
end

#2 for white, 0 for red, 1 for blue
start_node = {:state => "2011001100110011", :row => 0, :col => 0, :prev => nil}
target_state = "2101101001011010"

@nodes = [start_node]
@visited = [start_node[:state]]
q = 0
while q < @nodes.length
  puts q
  @cur_node = @nodes[q]
  q += 1
  @s = @cur_node[:state]
  @r = @cur_node[:row]
  @c = @cur_node[:col]

  #BINGO
  if @s == target_state
    def trace node
      if node[:prev].nil?
        return
      else
        trace(node[:prev])
      end
      r1 = node[:prev][:row]
      c1 = node[:prev][:col]
      r2 = node[:row]
      c2 = node[:col]
      if r2 == r1 - 1
        puts "U"
      elsif r2 == r1 + 1
        puts "D"
      elsif c2 == c1 - 1
        puts "L"
      else
        puts "R"
      end

    end

    trace @cur_node
    break
  end

  def move row, col
    if row >= 0 && row < STATIC_PLANE && col >= 0 and col < STATIC_PLANE
      state = swap(@s, @r, @c, row, col)
      unless @visited.include? state
        @visited << state
        @nodes << {:state => state, :row => row, :col => col, :prev => @cur_node}
      end
    end
  end

  move(@r - 1, @c)
  move(@r + 1, @c)
  move(@r, @c - 1)
  move(@r, @c + 1)
end
