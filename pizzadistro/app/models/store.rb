class Store < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :location, inverse_of: :store, dependent: :destroy
  
  validates_presence_of :location
  validates_associated :location
end
