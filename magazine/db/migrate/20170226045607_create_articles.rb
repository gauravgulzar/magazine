class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description

      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
