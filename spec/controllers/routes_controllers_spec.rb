require 'spec_helper'

describe RoutesController do

  describe "for loged in users" do

    before(:each) do
      @user = User.make id: 1
      @route = Route.make id: 123, user_id: @user.id
      controller.stub(current_user: @user)
    end

    describe "index" do

      it 'should show the right routes' do
        Route.should_receive(:where).with(user_id: 1).and_return(stub.as_null_object)
        get :index
      end

      it 'should use the correct template' do
        Route.stub(where: ["test_route1", "test_route2"])
        get :index, id: 1
        response.should render_template :index
      end

      it 'should render json correctly' do
        Route.stub(where: [@route])
        get :index, format: :json

        response.should be_ok
        response.body.should == [@route].to_json
        response.content_type.should == 'application/json'
      end

    end

    describe "show" do

      it 'should show the right route' do
        Route.should_receive(:find_by_id_and_user_id!).with(123, 1).and_return(stub.as_null_object)
        get :show, id: 123
      end

      it 'should use the correct template' do
        Route.stub(find_by_id_and_user_id!: "test_route")
        get :show, id: 123
        response.should render_template :show
      end

      it 'should render json correctly' do
        Route.stub(find_by_id_and_user_id!: @route)
        get :show, id: 123, format: :json

        response.should be_ok
        response.body.should == @route.to_json
        response.content_type.should == 'application/json'
      end

    end

    describe "create" do
      it 'should create the right record' do
        Route.should_receive(:create!).with(name: :test_route, user_id: 1).and_return(stub.as_null_object)
        post :create, route: {name: :test_route}
      end

      it 'should redirect to index' do
        Route.stub(create: "test_route")
        post :create, route: {name: 'test_route'}
        response.should redirect_to action: :index
      end

      it 'should json correctly' do
        Route.stub(create!: @route)
        post :create, route: {name: 'test_route'}, format: :json

        response.should be_ok
        response.body.should == @route.to_json
        response.content_type.should == 'application/json'
      end
    end

    describe "new" do

      it 'should should render the right template' do
        get :new
        response.should render_template :new
      end

    end

    describe "update" do

      it 'should use the correct route and updates' do
        Route.should_receive(:find_by_id_and_user_id!).with(123, 1).and_return(@route)
        @route.should_receive(:update_attribute).with(:name, :updated_test_route)
        post :update, id: 123, route: {name: :updated_test_route}
      end

      it 'should redirect to index' do
        Route.should_receive(:find_by_id_and_user_id!).with(123, 1).and_return(stub.as_null_object)
        post :update, id: 123, route: {name: :updated_test_route}

        response.should redirect_to action: :index
      end

      it 'should render json correctly' do
        Route.stub(find_by_id_and_user_id!: @route)
        @route.stub(update_attribute: @route)
        get :update, id: 123, format: :json, route: {name: :updated_route_name}

        response.should be_ok
        response.body.should == @route.to_json
        response.content_type.should == 'application/json'
      end

    end

  end
end
