class AddQuestionAndAnswerToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :question, :string
    add_column :users, :answer_hash, :string
    add_column :users, :answer_salt, :string
  end

  def self.down
    remove_column :users, :answer_hash
    remove_column :users, :answer_salt
    remove_column :users, :question
  end
end
