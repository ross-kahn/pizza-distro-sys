class Distro < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :location, inverse_of: :distro, dependent: :destroy
  
  validates_presence_of :location
  validates_associated :location
  
  accepts_nested_attributes_for :location
  
end
