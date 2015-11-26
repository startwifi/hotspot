require 'rails_helper'

RSpec.describe "admin/schedulers/index", type: :view do
  before(:each) do
    assign(:admin_scheduler_events, [
      Admin::Scheduler::Event.create!(),
      Admin::Scheduler::Event.create!()
    ])
  end

  it "renders a list of admin/schedulers" do
    render
  end
end
