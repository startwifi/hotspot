class RemoveSmsFromCompanies < ActiveRecord::Migration
  def up
    remove_column :companies, :sms
  end

  def down
    add_column :companies, :sms, :boolean, default: false
  end
end
