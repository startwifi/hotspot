module ControllersSpecHelper
  def sign_in_admin(global = false)
    before do
      @admin = global ? create(:admin, admin: global, company: nil) : create(:admin)
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in @admin
    end
  end
end
