class AddProviderToEvents < ActiveRecord::Migration
  def change
    add_column :events, :provider, :string
  end
end
