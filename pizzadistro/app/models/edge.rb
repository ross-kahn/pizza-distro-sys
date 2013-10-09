class Edge < ActiveRecord::Base
  attr_accessible :type_id, :location1_id, :location2_id
  attr_reader :len
  # Has type (:through => CPM, CAP), Node1 (x,y), Node2 (x,y)
  
  validates_presence_of :type_id
  
  belongs_to :type
  belongs_to :location_1, :class_name => "Location"
  belongs_to :location_2, :class_name => "Location"
  
  def base_cost
	
  end
  
  def total_cost(inventory)
  
  end
  
  def carry_capactiy
  
  end
  
  def cost_per_mile
  
  end
  
  def length
	@len ||= calculate_length()
  end
  
  private
  
	  def calculate_length
		x2 = location_2.x
		x1 = location_1.x
		
		y2 = location_2.y
		y1 = location_1.y
		
		xterm = (x2 - x1) * (x2 - x1)
		yterm = (y2 - y1) * (y2 - y1)
		
		return Math.sqrt(xterm + yterm)
	  end
  
end
