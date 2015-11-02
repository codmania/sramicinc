require 'rails_helper'

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

RSpec.describe WatchListsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # WatchList. As you add validations to WatchList, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WatchListsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all watch_lists as @watch_lists" do
      watch_list = WatchList.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:watch_lists)).to eq([watch_list])
    end
  end

  describe "GET #show" do
    it "assigns the requested watch_list as @watch_list" do
      watch_list = WatchList.create! valid_attributes
      get :show, {:id => watch_list.to_param}, valid_session
      expect(assigns(:watch_list)).to eq(watch_list)
    end
  end

  describe "GET #new" do
    it "assigns a new watch_list as @watch_list" do
      get :new, {}, valid_session
      expect(assigns(:watch_list)).to be_a_new(WatchList)
    end
  end

  describe "GET #edit" do
    it "assigns the requested watch_list as @watch_list" do
      watch_list = WatchList.create! valid_attributes
      get :edit, {:id => watch_list.to_param}, valid_session
      expect(assigns(:watch_list)).to eq(watch_list)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new WatchList" do
        expect {
          post :create, {:watch_list => valid_attributes}, valid_session
        }.to change(WatchList, :count).by(1)
      end

      it "assigns a newly created watch_list as @watch_list" do
        post :create, {:watch_list => valid_attributes}, valid_session
        expect(assigns(:watch_list)).to be_a(WatchList)
        expect(assigns(:watch_list)).to be_persisted
      end

      it "redirects to the created watch_list" do
        post :create, {:watch_list => valid_attributes}, valid_session
        expect(response).to redirect_to(WatchList.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved watch_list as @watch_list" do
        post :create, {:watch_list => invalid_attributes}, valid_session
        expect(assigns(:watch_list)).to be_a_new(WatchList)
      end

      it "re-renders the 'new' template" do
        post :create, {:watch_list => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested watch_list" do
        watch_list = WatchList.create! valid_attributes
        put :update, {:id => watch_list.to_param, :watch_list => new_attributes}, valid_session
        watch_list.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested watch_list as @watch_list" do
        watch_list = WatchList.create! valid_attributes
        put :update, {:id => watch_list.to_param, :watch_list => valid_attributes}, valid_session
        expect(assigns(:watch_list)).to eq(watch_list)
      end

      it "redirects to the watch_list" do
        watch_list = WatchList.create! valid_attributes
        put :update, {:id => watch_list.to_param, :watch_list => valid_attributes}, valid_session
        expect(response).to redirect_to(watch_list)
      end
    end

    context "with invalid params" do
      it "assigns the watch_list as @watch_list" do
        watch_list = WatchList.create! valid_attributes
        put :update, {:id => watch_list.to_param, :watch_list => invalid_attributes}, valid_session
        expect(assigns(:watch_list)).to eq(watch_list)
      end

      it "re-renders the 'edit' template" do
        watch_list = WatchList.create! valid_attributes
        put :update, {:id => watch_list.to_param, :watch_list => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested watch_list" do
      watch_list = WatchList.create! valid_attributes
      expect {
        delete :destroy, {:id => watch_list.to_param}, valid_session
      }.to change(WatchList, :count).by(-1)
    end

    it "redirects to the watch_lists list" do
      watch_list = WatchList.create! valid_attributes
      delete :destroy, {:id => watch_list.to_param}, valid_session
      expect(response).to redirect_to(watch_lists_url)
    end
  end

end
