class AddSsidAndRadioMacToRouter < ActiveRecord::Migration
  def change
    add_column :routers, :ssid, :string
    add_column :routers, :radio_mac, :macaddr
  end
end
