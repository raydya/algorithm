# coding: utf-8
# from yaraki: https://gist.github.com/yaraki/1730288

class Edge
  attr_accessor :src, :dst, :length

  def initialize(src, dst, length = 1)
    @src = src
    @dst = dst
    @length = length
  end
end

class Graph < Array
  attr_reader :edges

  def initialize
    @edges = []
  end

  def connect(src, dst, length = 1)
    fail ArgumentException, "No Such Vertex: #{src}" unless include?(src)
    fail ArgumentException, "No Such Vertex: #{dst}" unless include?(dst)
    @edges.push Edge.new(src, dst, length)
  end

  def connect_mutually(vertex1, vertex2, length = 1)
    connect vertex1, vertex2, length
    connect vertex2, vertex1, length
  end

  def neighbors(vertex)
    neighbors = []
    @edges.each do |edge|
      neighbors.push edge.dst if edge.src == vertex
    end
    neighbors.uniq
  end

  def length_between(src, dst)
    @edges.each do |edge|
      return edge.length if edge.src == src && edge.dst == dst
    end
    nil
  end

  def dijkstra(src, dst = nil)
    distances = {}
    previouses = {}
    # 建立顶点间距离
    each do |vertex|
      distances[vertex] = nil
      previouses[vertex] = nil
    end
    distances[src] = 0
    vertices = clone
    until vertices.empty?
      p "vertices is #{vertices}"
      # 获取现处理的顶点
      nearest_vertex = vertices.inject do |a, b|
        next b unless distances[a]
        next a unless distances[b]
        next a if distances[a] < distances[b]
        b
      end
      # 现处理顶点距离不存在
      break unless distances[nearest_vertex]
      # 到达目的顶点
      return distances[dst] if dst && nearest_vertex == dst
      # 获取现处理顶点的相邻的顶点
      neighbors = vertices.neighbors(nearest_vertex)
      p "distances: #{distances}"
      p "neighbors: #{neighbors}"
      p "nearest_vertex: #{nearest_vertex}"
      p "nearest_vertex distance: #{distances[nearest_vertex]}"
      neighbors.each do |vertex|
        p "vertex: #{vertex}"
        p "vertices length between #{nearest_vertex} and #{vertex} is #{vertices.length_between(nearest_vertex, vertex)}"
        p "distances vertex #{vertex} is #{distances[vertex]}"
        # 可能的短路径 = 现距离顶点的距离 + 现处理顶点到相邻顶点的距离
        alt = distances[nearest_vertex] + vertices.length_between(nearest_vertex, vertex)
        # 是否是短路径
        next unless distances[vertex].nil? || alt < distances[vertex]
        # 设短路径
        distances[vertex] = alt
        # 设上一个经过的顶点
        previouses[vertex] = nearest_vertex
        p "new distances vertex #{vertex} is #{alt}"
        p "new previouses vertex #{vertex} is #{nearest_vertex}"
      end
      # 删除已处理的顶点
      vertices.delete nearest_vertex
    end
    return nil if dst
    distances
  end
end

graph = Graph.new
(1..6).each { |node| graph.push node }
graph.connect_mutually 1, 2, 7
graph.connect_mutually 1, 3, 9
graph.connect_mutually 1, 6, 14
graph.connect_mutually 2, 3, 10
graph.connect_mutually 2, 4, 15
graph.connect_mutually 3, 4, 11
graph.connect_mutually 3, 6, 2
graph.connect_mutually 4, 5, 6
graph.connect_mutually 5, 6, 9

p graph
p graph.length_between(2, 1)
p graph.neighbors(1)
p graph.dijkstra(1, 5)
