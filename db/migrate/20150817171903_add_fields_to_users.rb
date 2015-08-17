class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date
    add_column :users, :url, :string
  end
end
