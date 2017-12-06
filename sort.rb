require 'benchmark'

class Array
  def bubble_sort!
    (0..(size - 1)).each do |i|
      (0..(size - i - 1)).each do |j|
        next if self[j + 1].nil?
        self[j], self[j + 1] = self[j + 1], self[j] if self[j] > self[j + 1]
      end
    end
    self
  end

  def quick_sort!
    return self if size < 2
    pivot = first
    left, right = self[1..-1].partition { |ele| ele <= pivot }
    left.quick_sort! + [pivot] + right.quick_sort!
  end

  def swap(x, y)
    tmp = self[x]
    self[x] = self[y]
    self[y] = tmp
  end

  def max_heapify(start_at, end_at)
    dad = start_at
    son = dad * 2 + 1
    return if son >= end_at
    son += 1 if son + 1 < end_at && self[son] < self[son + 1]
    if self[dad] <= self[son]
      swap(dad, son)
      max_heapify(son, end_at)
    end
  end

  def heap_sort!
    (size / 2 - 1).downto(0) do |i|
      max_heapify(i, size)
    end
    (size - 1).downto(1) do |i|
      swap(0, i)
      max_heapify(0, i)
    end
    self
  end
end

array = Array.new(100_000) { rand(1..9_999) }

Benchmark.bmbm do |x|
  x.report('default') { array.dup.sort }
  # x.report('bubble') { array.dup.bubble_sort! }
  x.report('quick') { array.dup.quick_sort! }
  x.report('heap') { array.dup.heap_sort! }
end
