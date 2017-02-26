class AddIndexToTaggings < ActiveRecord::Migration[5.0]
  def change
  	add_index :taggings, [:taggable_id, :tag_id], :unique => true
  end
end
