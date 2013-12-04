class Location < ActiveRecord::Base
  attr_accessible :x, :y
  
  # Can be L's with same X *or* same Y, but not same X *and* same Y
  validates_uniqueness_of :x, :scope => :y,
		:message => "A node at this location already exists"
  
  # validates_presence_of :store, allow_nil: true
  # validates_presence_of :distro, allow_nil: true
  
  # validate :store_xor_distro
  
  has_one :store, inverse_of: :location
  has_one :distro, inverse_of: :location
  
  def coord_s
	nodeid = inverse_s
	return nodeid + "(" + x.to_s + ", " + y.to_s + ")"
  end
  
  def inverse
	if !(store.blank?)
	  return store
	elsif !(distro.blank?)
	  return distro
	else
	  return nil
	end
  end
  
  def inverse_s
	nodeid = ""
	if !(store.blank?)
		nodeid = "S" + store.id.to_s
	else
		nodeid = "D" + distro.id.to_s
	end
	
	return nodeid
  end
  
  def equals?(location)
	if (location.instance_of? (Location))
		if( (location.x == x) && (location.y == y))
			return true
		else
			return false
		end
	else
		return false
	end
  end
  
  def to_s
	return "Location: " + inverse_s
  end
  
  # # Return either the store or distribution center this location is tied to
  # def node
	# if !(store.blank?)
		# return store
	# else
		# return distro
	# end
  # end
  
  # private
	# # Validate that a node exists, whether it's a store or distro
	# def store_xor_distro
		# if !(store.blank? ^ distro.blank?)
			# errors.add(:base, "A Location is tied to exactly one of either a store or a distribution center; cannot be both, and one must exist.")
		# end
	# end
end
