class ChangeDataTypeForPhone < ActiveRecord::Migration[5.0]

def self.up
    change_table :posts do |t|
      t.change :phone, :string
    end
  end
  
  def self.down
    change_table :posts do |t|
      t.change :phone, :string
    end
  end

end

