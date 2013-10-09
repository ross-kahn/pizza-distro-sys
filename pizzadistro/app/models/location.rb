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
