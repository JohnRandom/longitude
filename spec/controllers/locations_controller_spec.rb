require 'spec_helper'

describe LocationsController do

  describe 'logged in users' do

    before(:each) do
      @user = stub_model(User)
      @location = stub_model(Location)
      @route = stub_model(Route, locations: [@location])
      controller.stub(current_user: @user)
    end

    describe 'index' do

      it 'should render all the locations associated to the routeand assign @route and @location' do
        @user.routes.should_receive(:find).with(@route.id).and_return(@route)
        @route.should_receive(:locations).and_return([@location])

        get :index, route_id: @route.id
        assigns[:locations].should == [@location]
        assigns[:route].should == @route
      end

      it 'should render json correctly' do
        @user.routes.should_receive(:find).with(@route.id).and_return(@route)
        @route.should_receive(:locations).and_return([@location])

        get :index, route_id: @route.id, format: :json
        response.should be_ok
        response.body.should == [@location].to_json
        response.content_type.should == 'application/json'
      end

    end

    describe 'show' do

      it 'should render the given location and assign @route and @location' do
        @user.routes.should_receive(:find).with(@route.id).and_return(@route)
        @route.locations.should_receive(:find).with(@location.id).and_return(@location)

        get :show, route_id: @route.id, id: @location.id
        assigns[:route].should == @route
        assigns[:location].should == @location
      end

      it 'should render json correctly' do
        @user.routes.stub(:find).with(@route.id).and_return(@route)
        @route.locations.should_receive(:find).with(@location.id).and_return(@location)

        get :show, route_id: @route.id, id: @location.id, format: :json
        response.should be_ok
        response.body.should == @location.to_json
        response.content_type.should == 'application/json'
      end

    end

    describe 'create' do

      it 'should create location on the specified route and assign @route and @location' do
        @user.routes.should_receive(:find).with(@route.id).and_return(@route)
        @route.locations.should_receive(:create).with(latitude: 1.0, longitude: 1.0, user_id: @user.id).and_return(@location)

        post :create, route_id: @route.id, location: {latitude: 1.0, longitude: 1.0}
        assigns[:route].should == @route
        assigns[:location].should == @location
      end

      it 'should redirect to edit_route_url after route creation' do
        @user.routes.stub(find: @route)
        @route.locations.stub(create: @location)

        post :create, route_id: @route.id, location: {latitude: 1.0, longitude: 1.0}
        response.should redirect_to controller: :routes, action: :edit, id: @route.id
      end

      it 'should render json instead of redirection, when json format was requested' do
        @user.routes.stub(find: @route)
        @route.locations.stub(create: @location)

        post :create, route_id: @route.id, location: {latitude: 1.0, longitude: 1.0}, format: :json
        response.should be_ok
        response.body.should == @location.to_json
        response.content_type.should == 'application/json'
      end

    end

    describe 'destroy' do

      it 'should destroy the correct location and redirect to the edit_route_url' do
        @user.routes.stub(find: @route)
        @route.locations.should_receive(:find).with(@location.id).and_return(@location)
        @location.should_receive(:destroy)

        post :destroy, route_id: @route.id, id: @location.id
        response.should redirect_to edit_route_url(@route)
      end

      it 'should return header "ok" and empty body on json request when deletion was successful' do
        @user.routes.stub(find: @route)
        @route.locations.should_receive(:find).with(@location.id).and_return(@location)
        @location.should_receive(:destroy)

        post :destroy, route_id: @route.id, id: @location.id, format: :json
        response.should be_ok
        response.body.should == " "
        response.content_type.should == 'application/json'
      end

    end
  end

end
