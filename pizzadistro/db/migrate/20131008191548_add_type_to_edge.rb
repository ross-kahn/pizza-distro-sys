class AddTypeToEdge < ActiveRecord::Migration
  def change
    add_column :edges, :type_id, :integer
  end
end
