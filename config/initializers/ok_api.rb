Odnoklassniki.configure do |c|
  c.application_key = Rails.application.secrets.ok_public
  c.client_id       = Rails.application.secrets.ok_key
  c.client_secret   = Rails.application.secrets.ok_secret
end

