class AddCredentialsToVk < ActiveRecord::Migration[5.0]
  def change
    add_column :vks, :api_key, :string
    add_column :vks, :api_secret, :string
  end
end
