class CreateRouters < ActiveRecord::Migration
  def change
    create_table :routers do |t|
      t.integer :company_id, null: false
      t.string :ip_address, null: false
      t.string :name
      t.string :login, null: false
      t.string :password, null: false
      t.boolean :available, default: true
      t.datetime :last_pinged_at

      t.timestamps
    end

    add_index :routers, :company_id
    add_index :routers, [:ip_address, :company_id], unique: true
  end
end
