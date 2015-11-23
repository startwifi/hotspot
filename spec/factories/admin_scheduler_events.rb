FactoryGirl.define do
  factory :admin_scheduler_event, :class => 'Admin::Scheduler::Event' do
    name "MyString"
description "MyString"
startTime "2015-11-23 03:50:39"
endTime "2015-11-23 03:50:39"
repeat "MyString"
company nil
  end

end
