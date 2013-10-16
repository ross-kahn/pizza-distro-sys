class Type < ActiveRecord::Base
  attr_accessible :name, :carrycap, :cpm
  
  def color
	if name == "Airplane"
		return "red"
	elsif name == "Boat"
		return "blue"
	elsif name == "Truck"
		return "orange"
	else
		return "black"
	end
  end
end
