class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :token
      t.string :phone
      t.string :address

      t.timestamps null: false
    end
  end
end
