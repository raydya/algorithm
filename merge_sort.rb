require 'benchmark'

def merge_sort(list)
  return list if list.size <= 1
  pivot = list.size / 2
  left = merge_sort(list[0, pivot])
  right = merge_sort(list[pivot, list.size - 1])
  merge(left, right)
end

def merge(left, right)
  result = []
  while left.size > 0 && right.size > 0
    result << (left.first < right.first ? left.shift : right.shift)
  end
  result += left if left.size > 0
  result += right if right.size > 0
  result
end

array = Array.new(100_000) { rand(1..9_999) }

Benchmark.bmbm do |x|
  x.report('default') { array.dup.sort }
  x.report('merge_sort') { merge_sort(array.dup) }
end
