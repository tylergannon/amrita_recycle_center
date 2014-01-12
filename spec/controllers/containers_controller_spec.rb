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

describe ContainersController do

  # This should return the minimal set of attributes required to create a valid
  # Container. As you add validations to Container, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString", capacity: "1", "empty_weight" => "2" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContainersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all containers as @containers" do
      container = create(:container)
      get :index, {}, valid_session
      assigns(:containers).should eq([Container.no_container, container])
    end
  end

  describe "GET show" do
    it "assigns the requested container as @container" do
      container = create(:container)
      get :show, {:id => container.to_param}, valid_session
      assigns(:container).should eq(container)
    end
  end

  describe "GET new" do
    it "assigns a new container as @container" do
      get :new, {}, valid_session
      assigns(:container).should be_a_new(Container)
    end
  end

  describe "GET edit" do
    it "assigns the requested container as @container" do
      container = create(:container)
      get :edit, {:id => container.to_param}, valid_session
      assigns(:container).should eq(container)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Container" do
        expect {
          post :create, {:container => valid_attributes}, valid_session
        }.to change(Container, :count).by(1)
      end

      it "assigns a newly created container as @container" do
        post :create, {:container => valid_attributes}, valid_session
        assigns(:container).should be_a(Container)
        assigns(:container).should be_persisted
      end

      it "redirects to the created container" do
        post :create, {:container => valid_attributes}, valid_session
        response.should redirect_to(Container.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved container as @container" do
        # Trigger the behavior that occurs when invalid params are submitted
        Container.any_instance.stub(:save).and_return(false)
        post :create, {:container => { "name" => "invalid value" }}, valid_session
        assigns(:container).should be_a_new(Container)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Container.any_instance.stub(:save).and_return(false)
        post :create, {:container => { "name" => "invalid value" }}, valid_session
        response.should be_redirect
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested container" do
        container = create(:container)
        # Assuming there are no other containers in the database, this
        # specifies that the Container created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Container.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => container.to_param, :container => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested container as @container" do
        container = create(:container)
        put :update, {:id => container.to_param, :container => valid_attributes}, valid_session
        assigns(:container).should eq(container)
      end

      it "redirects to the container" do
        container = create(:container)
        put :update, {:id => container.to_param, :container => valid_attributes}, valid_session
        response.should redirect_to(container)
      end
    end

    describe "with invalid params" do
      it "assigns the container as @container" do
        container = create(:container)
        # Trigger the behavior that occurs when invalid params are submitted
        Container.any_instance.stub(:save).and_return(false)
        put :update, {:id => container.to_param, :container => { "name" => "invalid value" }}, valid_session
        assigns(:container).should eq(container)
      end

      it "re-renders the 'edit' template" do
        container = create(:container)
        # Trigger the behavior that occurs when invalid params are submitted
        Container.any_instance.stub(:save).and_return(false)
        put :update, {:id => container.to_param, :container => { "name" => "invalid value" }}, valid_session
        response.should be_redirect
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested container" do
      container = create(:container)
      expect {
        delete :destroy, {:id => container.to_param}, valid_session
      }.to change(Container, :count).by(-1)
    end

    it "redirects to the containers list" do
      container = create(:container)
      delete :destroy, {:id => container.to_param}, valid_session
      response.should redirect_to(containers_url)
    end
  end

end
