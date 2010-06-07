class AddAddressAssociationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :address_id, :integer
    remove_column :users, :zip3
    remove_column :users, :zip4
    remove_column :users, :prefecture
    remove_column :users, :ward_area
  end

  def self.down
    remove_column :users, :address_id
    add_column :users, :zip3, :string
    add_column :users, :zip4, :string
    add_column :users, :prefecture, :string
    add_column :users, :ward_area, :string
  end
end
