class AddSmsAuthLinkRedirectToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :sms_auth_link_redirect, :string
  end
end
