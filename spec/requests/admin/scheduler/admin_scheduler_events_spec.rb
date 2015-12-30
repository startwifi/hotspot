require 'rails_helper'

RSpec.describe "Admin::Scheduler::Events", type: :request do
  describe "GET /admin_scheduler_events" do
    it "works! (now write some real specs)" do
      get admin_scheduler_events_path
      expect(response).to have_http_status(200)
    end
  end
end
