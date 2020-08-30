class AddImgUrlToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :img_url, :string
  end
end
