class Edge < ActiveRecord::Base
  attr_reader :len 
  attr_accessible :uid
  # Has type (:through => CPM, CAP), Node1 (x,y), Node2 (x,y)
  
  validates_presence_of :type_id
  validates_presence_of :uid
  
  validate :uniqueness_nodes
  validate :uniqueness_direction
  # VALIDATE THAT EDGE IS NOT A BI-DIRECTION OF ANOTHER EDGE (type difference?)
  
  belongs_to :type
  belongs_to :location1, :class_name => "Location"
  belongs_to :location2, :class_name => "Location"
  
  def base_cost
	return (type.cpm * length).round(2)
  end
  
  def total_cost(inventory)
	return base_cost * (inventory / carry_capacity).ceil
  end
  
  def carry_capacity
	return type.carrycap.to_f
  end
  
  def cost_per_mile
	return type.cpm
  end
  
  def length
	@len ||= calculate_length()
  end
  
  def color
	return type.color
  end
  
  def find_uid
	Edge.edge_uid(Map.size, location1, location2)
  end
  
  # The idea is that if x is unique, and y is unique, then xy (concatenated)
  # must also be unique
  def self.edge_uid(mapsize, loc1, loc2)
	# Get the unique ID for these locations, based off the map size
	loc1_uid = loc1.x * mapsize + loc1.y
	loc2_uid = loc2.x * mapsize + loc2.y
	
	# Put the locations in LID order
	e = [loc1_uid, loc2_uid].sort
	
	# Smush the LIDs together into a new, unique edge number.
	# This returns the same EID even if L1 and L2 are reversed
	return e.join.to_i
  end
  
  def == (other)
	self.class === other and
		other.uid == uid()
  end
  
  alias eql? ==
  
  def hash
	uid()
  end

  private
  
	  def calculate_length
		x2 = location2.x
		x1 = location1.x
		
		y2 = location2.y
		y1 = location1.y
		
		xterm = (x2 - x1) * (x2 - x1)
		yterm = (y2 - y1) * (y2 - y1)
		
		return Math.sqrt(xterm + yterm)
	  end
	  
	  # Can't make an edge to yourself
	  def uniqueness_nodes
		if Location.find(location1_id).equals?(Location.find(location2_id))
		  errors.add(:base, "An edge may not have the same start and end point")
		end
	  end
	  
	  # Can't make an edge to the same place of the same type
	  #  Case 1: edge with start==this.start && end==this.end (same direction)
	  #  Case 2: edge with end==this.start && start==this.end (reverse direction)
	  def uniqueness_direction
	  
		# There's an edge with start == this.start
		c1 = Edge.where(:location1_id => location1.id)
		
		# There's an edge with end == this.start
		c2 = Edge.where(:location2_id => location1.id)
		
		if !(c1.empty?)
			c1.each do |curedge|
				# An edge is found with the same start AND end points
				if (curedge.type_id == type_id) && (curedge.location2_id == location2.id)
					errors.add(:base, "There's already an edge between these two nodes")
					return
				end
			end
		
		elsif !(c2.empty?)
			c2.each do |curedge|
				# An edge going the opposite direction as this edge is found
				if (curedge.type_id == type_id) && (curedge.location1_id == location2.id)
					errors.add(:base, "There's already an edge between these two nodes (going the other direction)")
					return
				end
			end
		end
	  end
  
end
