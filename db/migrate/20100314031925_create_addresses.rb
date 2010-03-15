class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :zip
      t.string :prefecture
      t.string :ward
      t.string :area
    end
  end

  def self.down
    drop_table :addresses
  end
end
