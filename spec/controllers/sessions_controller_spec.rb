require 'spec_helper'

describe SessionsController do

  before(:each) do
    @user = stub_model(User, id: 1)
  end

  describe 'create' do
    it 'should put the user id into the session if user authenticates' do
      User.should_receive(:authenticate).with('test@localhost.de', 'test').and_return(@user)
      post :create, email: 'test@localhost.de', password: 'test'

      session.should include(user_id: @user.id)
    end

    it 'should redirect to Routes#index on successful authentication' do
      User.stub(authenticate: @user)
      post :create, email: 'test@localhost.de', password: 'test'

      response.should redirect_to controller: :routes, action: :index
    end

    it 'should render the new template on unsuccessful authentication' do
      User.stub(authenticate: nil)
      post :create, email: 'test@localhost.de', password: 'wrong_password'

      response.should render_template :new
    end
  end

  describe 'destroy' do
    it 'should reset the user id in the session' do
      post :destroy
      session.should_not include(user_id: @user.id)
    end

    it 'should redirect to the root url on session reset' do
      post :destroy
      response.should redirect_to root_url
    end
  end

end
