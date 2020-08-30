class AddCustomizedOptionToTags < ActiveRecord::Migration
  def change
    add_column :tags, :customized, :boolean
  end
end
