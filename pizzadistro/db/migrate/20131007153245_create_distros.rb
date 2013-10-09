class CreateDistros < ActiveRecord::Migration
  def change
    create_table :distros do |t|

      t.timestamps
    end
  end
end
