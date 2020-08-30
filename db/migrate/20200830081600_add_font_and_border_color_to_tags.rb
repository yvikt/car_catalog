class AddFontAndBorderColorToTags < ActiveRecord::Migration
  def change
    add_column :tags, :font_color, :string
    add_column :tags, :border_color, :string
  end
end
