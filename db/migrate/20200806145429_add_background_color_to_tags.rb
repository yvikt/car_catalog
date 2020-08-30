class AddBackgroundColorToTags < ActiveRecord::Migration
  def change
    add_column :tags, :bg_color, :string
  end
end
