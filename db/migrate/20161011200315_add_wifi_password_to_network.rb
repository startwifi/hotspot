class AddWifiPasswordToNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :wifi_password, :string
  end
end
