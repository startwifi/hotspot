class AddCoverToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :cover, :string
  end
end
