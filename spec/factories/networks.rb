FactoryGirl.define do
  factory :network do
    company nil
    local_network ""
    local_range_begin ""
    local_range_end ""
    local_gateway ""
    hotspot_network ""
    hotspot_range_begin ""
    hotspot_range_end ""
    hotspot_gateway ""
    hotspot_address ""
    net ""
    lease_time 1
  end
end
