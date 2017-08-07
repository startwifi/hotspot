class AddTokenToRouter < ActiveRecord::Migration[5.0]
  def change
    add_column :routers, :token, :string
  end
end
