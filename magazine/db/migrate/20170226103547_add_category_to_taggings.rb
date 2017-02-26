class AddCategoryToTaggings < ActiveRecord::Migration[5.0]
  def change
    add_column :taggings, :category, :integer
  end
end
