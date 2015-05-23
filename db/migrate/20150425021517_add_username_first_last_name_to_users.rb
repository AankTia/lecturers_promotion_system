class AddUsernameFirstLastNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false, default: ""
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :language, :string
    add_index :users, :username, unique: true
  end
end
