class AddCredentialsToIn < ActiveRecord::Migration[5.0]
  def change
    add_column :ins, :api_key, :string
    add_column :ins, :api_secret, :string
  end
end
