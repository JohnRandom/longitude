class RoutesController < ApplicationController

  # before filter
  before_filter :verify_loged_in
  before_filter :verify_params, :only => :create

  respond_to :html, :json

  def index
    @routes = Route.where :user_id => current_user.id

    respond_to do |format|
      format.html
      format.json { render :json => @routes }
    end
  end

  def show
    @route = Route.find_by_id_and_user_id!( params[:id], current_user.id )

    respond_to do |format|
      format.html
      format.json  { render :json => @route}
    end
  end

  def new
    @route = Route.new
  end

  def create
    p params
    route_name = params[:name]

    @route = Route.create! :name => route_name, :user_id => current_user.id
    redirect_to :action => :index and return

    respond_to do |format|
      format.json  { render :json => @route }
    end
  end

  def edit
    @route = Route.find params[:id]
  end

  def update
    @route = Route.find_by_id_and_user_id! params[:id], current_user.id
    @route.update_attribute( :name, params[:route][:name] ) if @route

      respond_to do |format|
      format.html { redirect_to :action => :index and return }
      format.json { render :json => @route }
    end
  end

  def destroy
    @route = Route.find_by_id_and_user_id! params[:id], current_user.id
    @route.destroy if @route

    flash.now.alert = "Route '#{@route.name}' deleted."
    respond_to do |format|
      format.html { redirect_to :action => :index and return }
      format.json { head :deleted }
    end
  end

  private

  def verify_params
    unless params[:name]
      flash.now.alert = "Invalid request parameters"
      redirect_to :controller => 'routes', :action => 'index'
    end
  end
end
