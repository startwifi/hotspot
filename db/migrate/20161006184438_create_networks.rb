class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.references :company, index: true, foreign_key: true
      t.cidr :local_network
      t.inet :local_range_begin
      t.inet :local_range_end
      t.inet :local_gateway
      t.cidr :hotspot_network
      t.inet :hotspot_range_begin
      t.inet :hotspot_range_end
      t.inet :hotspot_gateway
      t.inet :hotspot_address
      t.inet :net
      t.integer :lease_time

      t.timestamps null: false
    end
  end
end
