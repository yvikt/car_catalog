class AddTagCategoryToTags < ActiveRecord::Migration
  def change
    add_column :tags, :tag_category, :string
  end
end
