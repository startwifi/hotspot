require 'rails_helper'

RSpec.describe "admin/schedulers/edit", type: :view do
  before(:each) do
    @admin_scheduler = assign(:admin_scheduler, Admin::Scheduler::Event.create!())
  end

  it "renders the edit admin_scheduler form" do
    render

    assert_select "form[action=?][method=?]", admin_scheduler_path(@admin_scheduler), "post" do
    end
  end
end
