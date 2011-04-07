class RoutesController < ApplicationController

  # accessors
  # attribute_accessor :name

  # request validations
  before_filter :verify_loged_in
  before_filter :verify_params, :only => :create

  # so far, json only
  respond_to :html, :json

  def index
    @routes = Route.where :user_id => current_user.id
  end

  def show
    @route = Route.find_by_id_and_user_id( params[:id], current_user.id )

    respond_to do |format|
      format.html
      format.json  { render :json => @route}
    end
  end

  def new
    @route = Route.new
  end

  def create
    route_name = params[:name]

    @route = Route.create! :name => route_name, :user_id => current_user.id
    redirect_to :action => :index and return

    respond_to do |format|
      format.json  { render :json => @route}
    end
  end

  def edit
    @route = Route.find params[:id]
  end

  def update
    @route = Route.find_by_id_and_user_id params[:id], current_user.id
    @route.update_attribute( :name, params[:route][:name] ) if @route
    redirect_to :action => :index
  end

  def destroy
    @route = Route.find_by_id_and_user_id params[:id], current_user.id
    @route.destroy if @route

    flash.now.alert = "Route '#{@route.name}' deleted."
    redirect_to :action => :index
  end

  private

  def verify_params
    unless params[:name]
      flash.now.alert = "Invalid request parameters"
      redirect_to :controller => 'routes', :action => 'index'
    end
  end
end
