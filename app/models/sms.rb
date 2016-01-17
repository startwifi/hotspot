class Sms
  include ActiveModel::Model

  attr_accessor :phone

  validates_plausible_phone :phone, presence: true, with: /\A\+\d+/

end
