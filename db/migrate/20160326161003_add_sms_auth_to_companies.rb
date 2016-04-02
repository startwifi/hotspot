class AddSmsAuthToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :sms_auth, :string
  end
end
