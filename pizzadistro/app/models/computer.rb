class Computer
  
  def shortest_path(loc1, loc2, amount)
	graph = Location.all	# All nodes
	asize = graph.length	# Number of nodes
	
	previous = Hash.new()	# Previously 
	visited = Hash.new()	# Edges that have been visited
	distance = Hash.new()	# Edges to be computed
	
	graph.each do |node|
		distance[node] = Float::INFINITY
		visited[node] = false
		previous[node] = nil
	end
	
	distance[loc1] = 0		# Start node
	active = [] << loc1
	 
	until active.empty?
		bestnodeIndex = find_smallest_dist(active, visited, distance)
		bestnode = active.delete_at(bestnodeIndex)
		
		# Terminate search if target is reached
		if bestnode == loc2
			path = []
			curnode = loc2
			while previous[curnode]
				path << curnode
				curnode = previous[curnode]
			end
			return path
		end
		
		visited[bestnode] = true

		Map.neighbors_of(bestnode).each do |neighbor|
			newdistance = distance[bestnode] + cost_between(bestnode, neighbor, amount)
			if newdistance < distance[neighbor]
				distance[neighbor] = newdistance
				previous[neighbor] = bestnode
				if !visited[neighbor]
					active << neighbor
				end
			end #if
		end # for
	end # while
	
	return nil
  end
  
  private
  
	# Finds the edge with the smallest distance cost
	def find_smallest_dist(active, visited, distance)
		bestdist = Float::INFINITY
		bestnode = nil
		
		nodeIndex = 0
		active.each do |node|
			if (!visited[node]) && (distance[node] < bestdist)
				bestdist = distance[node]
				bestnode = nodeIndex
			end
			nodeIndex += 1
		end
		return bestnode
	end
	
	def cost_between(loc1, loc2, amount)
		edge = Map.find_edge(loc1, loc2)
		return edge.total_cost(amount)
	end
end