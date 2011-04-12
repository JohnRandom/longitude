require 'spec_helper'

describe RoutesController do

  describe 'for logged in users' do

    before(:each) do
      @route = stub_model(Route, id: 1)
      @user = stub_model(User, routes: [@route])
      controller.stub(current_user: @user)
    end

    describe 'index' do

      it 'should show the users routes' do
        @user.should_receive(:routes)
        get :index
      end

      it 'should assign @routes' do
        get :index
        assigns[:routes].should == [@route]
      end

      it 'should render json correctly' do
        get :index, format: :json

        response.should be_ok
        response.body.should == [@route].to_json
        response.content_type.should == 'application/json'
      end

    end

    describe 'show' do

      it 'should show the right route' do
        @user.routes.should_receive(:find).with('123')
        get :show, id: '123'
      end

      it 'should assign @route' do
        @user.routes.stub(find: @route)
        get :show, id: '123'
        assigns[:route].should == @route
      end

      it 'should render json correctly' do
        @user.routes.should_receive(:find).with('123').and_return(@route)
        get :show, id: '123', format: :json

        response.should be_ok
        response.body.should == @route.to_json
        response.content_type.should == 'application/json'
      end

    end

    describe 'create' do
      it 'should create the record and return the location in the header' do
        @user.routes.should_receive(:create).with(name: 'test_route').and_return(@route)
        post :create, route: {name: 'test_route'}
      end

      it 'should redirect to index' do
        @user.routes.stub(:create)
        post :create, route: {name: 'test_route'}
        response.should redirect_to action: :index
      end

      it 'should render json correctly' do
        @user.routes.stub(create: @route)
        post :create, route: {name: 'test_route'}, format: :json

        response.should be_ok
        response.body.should == @route.to_json
        response.content_type.should == 'application/json'
      end
    end

    describe 'update' do

      it 'should use the correct route and updates' do
        @user.routes.should_receive(:find).with('123').and_return(@route)
        @route.should_receive(:update_attribute).with(:name, 'updated_test_route')
        post :update, id: '123', route: {name: 'updated_test_route'}
      end

      it 'should redirect to index' do
        @user.routes.stub(find: @route)
        post :update, id: '123', route: {name: 'updated_test_route'}

        response.should redirect_to action: :index
      end

      it 'should render json correctly' do
        @user.routes.should_receive(:find).and_return(@route)
        @route.stub(update_attribute: @route)
        get :update, id: '123', format: :json, route: {name: 'updated_route_name'}

        response.should be_ok
        response.body.should == @route.to_json
        response.content_type.should == 'application/json'
      end

    end

    describe 'destroy' do

      it 'should destroy the user route' do
        @user.routes.should_receive(:find).with('123').and_return(@route)
        @route.should_receive(:destroy)
        get :destroy, id: '123'
      end

      it 'should redirect to index' do
        @user.routes.stub(find: @route)
        post :destroy, id: '123'

        response.should redirect_to action: :index
      end

      it 'should use head for json requests' do
        @user.routes.stub(find: @route)
        post :destroy, id: '123', format: :json

        response.should be_ok
        response.body.should == " "
        response.content_type.should == 'application/json'
      end

    end

  end
end
