Airbrake.configure do |c|
  c.project_id = Figaro.env.airbrake_project_id
  c.project_key = Figaro.env.airbrake_project_key
  c.root_directory = Rails.root
  c.logger = Rails.logger
  c.environment = Rails.env
  c.ignore_environments = %w(test)
  c.blacklist_keys = [/password/i]
end
