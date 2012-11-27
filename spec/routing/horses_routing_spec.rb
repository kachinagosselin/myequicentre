require "spec_helper"

describe HorsesController do
  describe "routing" do

    it "routes to #index" do
      get("/horses").should route_to("horses#index")
    end

    it "routes to #new" do
      get("/horses/new").should route_to("horses#new")
    end

    it "routes to #show" do
      get("/horses/1").should route_to("horses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/horses/1/edit").should route_to("horses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/horses").should route_to("horses#create")
    end

    it "routes to #update" do
      put("/horses/1").should route_to("horses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/horses/1").should route_to("horses#destroy", :id => "1")
    end

  end
end
