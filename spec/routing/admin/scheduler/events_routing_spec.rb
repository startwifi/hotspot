require "rails_helper"

RSpec.describe Admin::Scheduler::EventsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/schedulers").to route_to("admin/schedulers#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/schedulers/new").to route_to("admin/schedulers#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/schedulers/1").to route_to("admin/schedulers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/schedulers/1/edit").to route_to("admin/schedulers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/schedulers").to route_to("admin/schedulers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/schedulers/1").to route_to("admin/schedulers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/schedulers/1").to route_to("admin/schedulers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/schedulers/1").to route_to("admin/schedulers#destroy", :id => "1")
    end

  end
end
