class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.integer :cpm
      t.integer :carrycap

      t.timestamps
    end
  end
end
