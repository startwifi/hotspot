class CreateRouters < ActiveRecord::Migration
  def change
    create_table :routers do |t|
      t.references :company, index: true
      t.string :ip_address, null: false
      t.string :name
      t.string :login, null: false
      t.string :password, null: false
      t.boolean :available, default: false
      t.datetime :last_pinged_at

      t.timestamps
    end

    add_index :routers, [:ip_address, :company_id], unique: true
  end
end
