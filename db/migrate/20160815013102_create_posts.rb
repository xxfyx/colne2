class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :city
      t.integer :phone

      t.timestamps
    end
  end
end
