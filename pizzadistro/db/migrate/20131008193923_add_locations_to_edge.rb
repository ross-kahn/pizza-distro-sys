class AddLocationsToEdge < ActiveRecord::Migration
  def change
    add_column :edges, :location1_id, :integer
    add_column :edges, :location2_id, :integer
  end
end
