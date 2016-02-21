class AddTosToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :tos, :boolean, default: false
    add_column :companies, :tos_text, :text
  end
end
