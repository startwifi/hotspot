class AddPhoneToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :phone, :string
  end
end
