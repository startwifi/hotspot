class AddCredentialsToOk < ActiveRecord::Migration[5.0]
  def change
    add_column :oks, :api_key, :string
    add_column :oks, :api_secret, :string
    add_column :oks, :api_public, :string
  end
end
