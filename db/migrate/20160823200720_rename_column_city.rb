class RenameColumnCity < ActiveRecord::Migration[5.0]
  def change
  	rename_column :posts, :city, :city_id
  end
end
