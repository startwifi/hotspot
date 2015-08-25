class AddSocialsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :fb, :boolean, default: false
    add_column :companies, :vk, :boolean, default: false
    add_column :companies, :twitter, :boolean, default: false
  end
end
