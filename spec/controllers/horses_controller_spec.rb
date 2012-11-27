require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe HorsesController do

  # This should return the minimal set of attributes required to create a valid
  # Horse. As you add validations to Horse, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "name" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HorsesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all horses as @horses" do
      horse = Horse.create! valid_attributes
      get :index, {}, valid_session
      assigns(:horses).should eq([horse])
    end
  end

  describe "GET show" do
    it "assigns the requested horse as @horse" do
      horse = Horse.create! valid_attributes
      get :show, {:id => horse.to_param}, valid_session
      assigns(:horse).should eq(horse)
    end
  end

  describe "GET new" do
    it "assigns a new horse as @horse" do
      get :new, {}, valid_session
      assigns(:horse).should be_a_new(Horse)
    end
  end

  describe "GET edit" do
    it "assigns the requested horse as @horse" do
      horse = Horse.create! valid_attributes
      get :edit, {:id => horse.to_param}, valid_session
      assigns(:horse).should eq(horse)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Horse" do
        expect {
          post :create, {:horse => valid_attributes}, valid_session
        }.to change(Horse, :count).by(1)
      end

      it "assigns a newly created horse as @horse" do
        post :create, {:horse => valid_attributes}, valid_session
        assigns(:horse).should be_a(Horse)
        assigns(:horse).should be_persisted
      end

      it "redirects to the created horse" do
        post :create, {:horse => valid_attributes}, valid_session
        response.should redirect_to(Horse.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved horse as @horse" do
        # Trigger the behavior that occurs when invalid params are submitted
        Horse.any_instance.stub(:save).and_return(false)
        post :create, {:horse => { "name" => "invalid value" }}, valid_session
        assigns(:horse).should be_a_new(Horse)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Horse.any_instance.stub(:save).and_return(false)
        post :create, {:horse => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested horse" do
        horse = Horse.create! valid_attributes
        # Assuming there are no other horses in the database, this
        # specifies that the Horse created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Horse.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => horse.to_param, :horse => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested horse as @horse" do
        horse = Horse.create! valid_attributes
        put :update, {:id => horse.to_param, :horse => valid_attributes}, valid_session
        assigns(:horse).should eq(horse)
      end

      it "redirects to the horse" do
        horse = Horse.create! valid_attributes
        put :update, {:id => horse.to_param, :horse => valid_attributes}, valid_session
        response.should redirect_to(horse)
      end
    end

    describe "with invalid params" do
      it "assigns the horse as @horse" do
        horse = Horse.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Horse.any_instance.stub(:save).and_return(false)
        put :update, {:id => horse.to_param, :horse => { "name" => "invalid value" }}, valid_session
        assigns(:horse).should eq(horse)
      end

      it "re-renders the 'edit' template" do
        horse = Horse.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Horse.any_instance.stub(:save).and_return(false)
        put :update, {:id => horse.to_param, :horse => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested horse" do
      horse = Horse.create! valid_attributes
      expect {
        delete :destroy, {:id => horse.to_param}, valid_session
      }.to change(Horse, :count).by(-1)
    end

    it "redirects to the horses list" do
      horse = Horse.create! valid_attributes
      delete :destroy, {:id => horse.to_param}, valid_session
      response.should redirect_to(horses_url)
    end
  end

end
