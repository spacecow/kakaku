class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name_kana, :string
    add_column :users, :first_name_kana, :string
    add_column :users, :male, :boolean
		add_column :users, :home_tel, :string
		add_column :users, :mob_tel, :string
		add_column :users, :mob_email, :string
		remove_column :users, :email
		add_column :users, :pc_email, :string
		add_column :users, :zip3, :string
		add_column :users, :zip4, :string
		add_column :users, :prefecture, :string
		add_column :users, :ward, :string
		add_column :users, :area, :string
  end

  def self.down
    remove_column :users, :last_name
    remove_column :users, :first_name
    remove_column :users, :last_name_kana
    remove_column :users, :first_name_kana
    remove_column :users, :male
    remove_column :users, :home_tel
    remove_column :users, :mob_tel
    remove_column :users, :mob_email
    remove_column :users, :pc_email
    add_column :users, :email, :string
    remove_column :users, :zip3
    remove_column :users, :zip4
    remove_column :users, :prefecture
    remove_column :users, :ward
    remove_column :users, :area
  end
end
