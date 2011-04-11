require 'spec_helper'

describe RoutesController do

  describe "for loged in users" do

    before(:each) do
      @user = log_in
    end

    it 'should show the right route' do
      Route.should_receive(:find_by_id_and_user_id!).with(3, @user.id).and_return(stub.as_null_object)
      get :show, :id => 3
    end

    it 'should create the right record' do
      Route.should_receive(:create!).with(:name => :test_route, :user_id => @user.id).and_return(stub.as_null_object)
      post :create, :route => {:name => :test_route}
    end

    it "should not delete routes which doesn't belong to them" do
      route = Route.make(:user => @user).stub(:destroy => nil)
      route.should_not_receive(:destroy)
      post :destroy, :route => {:route_id => route.id}
    end

  end
end
