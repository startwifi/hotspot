class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :company, index: true
      t.macaddr :mac

      t.timestamps null: false
    end
  end
end
