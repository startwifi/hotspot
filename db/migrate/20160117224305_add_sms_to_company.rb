class AddSmsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :sms, :boolean, default: false
  end
end
