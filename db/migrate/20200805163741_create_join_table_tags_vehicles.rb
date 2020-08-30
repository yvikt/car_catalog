class CreateJoinTableTagsVehicles < ActiveRecord::Migration
  def change
    create_join_table :tags, :vehicles do |t|
      t.index [:tag_id, :vehicle_id]
      t.index [:vehicle_id, :tag_id]
    end
  end
end
