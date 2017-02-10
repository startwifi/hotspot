class AddCredentialsToFb < ActiveRecord::Migration[5.0]
  def change
    add_column :fbs, :api_key, :string
    add_column :fbs, :api_secret, :string
  end
end
