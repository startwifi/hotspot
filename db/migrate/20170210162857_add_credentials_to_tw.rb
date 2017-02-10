class AddCredentialsToTw < ActiveRecord::Migration[5.0]
  def change
    add_column :tws, :api_key, :string
    add_column :tws, :api_secret, :string
  end
end
