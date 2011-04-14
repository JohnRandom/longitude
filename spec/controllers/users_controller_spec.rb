require 'spec_helper'

describe UsersController do

  before(:each) do
    @user = stub_model(User, save: true)
    @credentials = {email: 'test@localhost.de', password: 'test', password_confirmation: 'test'}.with_indifferent_access
  end

  describe 'on successful user creation' do
    it 'should create a user with given credentials' do
      User.should_receive(:new).with(@credentials).and_return(@user)
      post :create, user: @credentials
    end

    it 'should redirect to root url on successful creation' do
      User.stub(new: @user)
      post :create, @credentials

      response.should redirect_to root_url
    end
  end

  describe 'on unsuccessful user creation'do
    it 'should render template for "new"' do
      User.stub(new: @user)
      @user.stub(save: false)
      post :create, user: @credentials

      response.should render_template(:new)
    end
  end
end
