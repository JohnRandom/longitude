class RoutesController < ApplicationController

  # request validations
  before_filter :verify_loged_in
  before_filter :verify_params, :only => [:destroy, :create, :update, :new]

  # so far, json only
  respond_to :json

  def show
    user = User.find_by_username( params[:username] )
    @route = Route.find_by_id_and_user_id( params[:id], user.id )

    respond_to do |format|
      format.json  { render :json => @route}
    end
  end

  def new
    # TODO: how to fail on invalid query params?
    username = params[:username]
    route_name = params[:name]

    @user = User.find_by_username username
    @route = Route.create! :name => route_name, :user_id => @user.id if not Route.where( :name => route_name, :user_id => @user.id ).exists?

    respond_to do |format|
      format.json  { render :json => @route}
    end
  end

  def update
    route = Route.find( params[:id] )
    route.update_attribute( :name, params[:name] )
    respond_with route
  end

  private

  def verify_params
    unless params[:name]
      redirect_to :controller => 'routes', :action => 'index'
    end
  end
end
