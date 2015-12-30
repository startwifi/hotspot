require 'rails_helper'

RSpec.describe "admin/schedulers/new", type: :view do
  before(:each) do
    assign(:admin_scheduler, Admin::Scheduler::Event.new())
  end

  it "renders new admin_scheduler form" do
    render

    assert_select "form[action=?][method=?]", admin_scheduler_events_path, "post" do
    end
  end
end
