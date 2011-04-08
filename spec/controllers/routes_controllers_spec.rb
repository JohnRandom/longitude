require 'spec_helper'

describe RoutesController do

  before(:each) do
    @user = log_in
  end

  describe 'show' do
    it 'should fetch the right route' do
      Route.should_receive(:find_by_id_and_user_id!).with(3, @user.id).and_return(stub.as_null_object)
      get :show, :id => 3
    end
  end

  describe 'create' do
    it 'should create the right record' do
      Route.should_receive(:create!).with(:name => :test_route, :user_id => @user.id).and_return(stub.as_null_object)
      post :create, :route => {:name => :test_route}
    end
  end
end
