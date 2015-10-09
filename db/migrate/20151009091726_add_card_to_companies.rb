class AddCardToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :card, :string
  end
end
