Odnoklassniki.configure do |c|
  c.application_key = Figaro.env.ok_public
  c.client_id       = Figaro.env.ok_key
  c.client_secret   = Figaro.env.ok_secret
end

