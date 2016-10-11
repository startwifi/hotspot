class Network < ActiveRecord::Base
  belongs_to :company

  validates :local_network, :local_range_begin, :local_range_end, :local_gateway,
            :hotspot_network, :hotspot_range_begin, :hotspot_range_end,
            :hotspot_gateway, :hotspot_address, :net, :lease_time, presence: true

  class << self
    def generate_password
      rand(36**8).to_s(36)
    end
  end
end
