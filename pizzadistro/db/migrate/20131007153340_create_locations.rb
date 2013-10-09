class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
