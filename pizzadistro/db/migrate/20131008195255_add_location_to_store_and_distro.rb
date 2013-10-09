class AddLocationToStoreAndDistro < ActiveRecord::Migration
  def change
    add_column :stores, :location_id, :integer
    add_column :distros, :location_id, :integer
  end
end
