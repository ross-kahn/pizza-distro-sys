class AddUidColumnToEdge < ActiveRecord::Migration
  def change
    add_column :edges, :uid, :integer
  end
end
