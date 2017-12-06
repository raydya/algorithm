require 'benchmark'

# coding: utf-8
# binary_search
class Array
  def binary_search(target, start_at = nil, end_at = nil)
    start_at ||= 0
    end_at ||= size - 1
    return if start_at > end_at
    mid = (start_at + end_at) / 2
    return binary_search(target, start_at, mid - 1) if target < self[mid]
    return binary_search(target, mid + 1, end_at) if target > self[mid]
    mid
  end
end

array = Array.new(10_000_000) { rand(1..9_999) }
expected = rand(1..9_999)
sorted = array.sort

Benchmark.bmbm do |x|
  x.report('default') { array.dup.index(expected) }
  x.report('binary_search') { sorted.dup.binary_search(expected) }
end
