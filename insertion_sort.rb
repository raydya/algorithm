class Array
  def insertion_sort
    i = 0
    while i < size
      current = self[i]
      j = i
      while j > 0 && self[j - 1] > current
        self[j] = self[j - 1]
        j -= 1
      end
      p j
      p current
      self[j] = current
      i += 1
    end
  end
end

# array = Array.new(100_000) { rand(1..9_999) }
array = Array.new(5) { rand(1..20) }
p array
array.insertion_sort
