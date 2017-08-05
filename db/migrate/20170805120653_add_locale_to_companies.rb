class AddLocaleToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :locale, :string, default: 'ru'
  end
end
