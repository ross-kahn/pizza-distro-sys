class Map < ActiveRecord::Base
  # attr_accessible :title, :body
  
  def self.size
	return 20
  end
  
  def self.neighbors_of(location)
	neighbors = []
	edges = Edge.where('location1_id=? OR location2_id=?', location.id, location.id)
	
	edges.each do |e|
		if e.location1_id == location.id
			neighbors << e.location2
		else
			neighbors << e.location1
		end
	end
	return neighbors
  end
  
  def self.find_edge(location1, location2)
  
	uid = Edge.edge_uid(size, location1, location2)
	return Edge.where(:uid=>uid).first
	
  end
 
end
