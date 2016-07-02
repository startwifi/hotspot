class AddLayoutToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :layout, :string
  end
end
