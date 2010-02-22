class CreateResets < ActiveRecord::Migration
  def self.up
    create_table :resets do |t|
      t.integer :user_id
      t.string :token
      t.boolean :used, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :resets
  end
end
