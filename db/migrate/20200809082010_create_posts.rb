class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, limit: 30, null: false
      t.string :image
      t.text :description
      t.string :address

      t.timestamps
    end
  end
end
