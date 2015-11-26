require 'rails_helper'

RSpec.describe "admin/schedulers/show", type: :view do
  before(:each) do
    @admin_scheduler = assign(:admin_scheduler, Admin::Scheduler::Event.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
