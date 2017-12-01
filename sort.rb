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
end

def quick_sort_func(array)
  return array if array.size < 2
  pivot = array.first
  left, right = array[1..-1].partition { |ele| ele <= pivot }
  quick_sort_func(left) + [pivot] + quick_sort_func(right)
end

array = Array.new(10_000) { rand(1..9999) }

Benchmark.bmbm do |x|
  x.report('default') { array.dup.sort }
  x.report('bubble') { array.dup.bubble_sort! }
  x.report('quick')  { quick_sort_func(array.dup) }
end
