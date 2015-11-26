json.array!(@admin_scheduler_events) do |admin_scheduler_event|
  json.extract! admin_scheduler_event, :id
  json.url admin_scheduler_event_url(admin_scheduler_event, format: :json)
end
