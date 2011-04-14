class RoutesController < ApplicationController

  before_filter :verify_loged_in

  respond_to :html, :json

  def index
    @routes = current_user.routes

    respond_to do |format|
      format.html
      format.json { render :json => @routes }
    end
  end

  def show
    @route = current_user.routes.find params[:id]

    respond_to do |format|
      format.html
      format.json  { render :json => @route}
    end
  end

  def new
    @route = Route.new
  end

  def create
    route = current_user.routes.create params[:route]

    flash.alert = "Route created"
    respond_to do |format|
      format.html { redirect_to :action => :index and return }
      format.json { render :json => route }
    end
  end

  def edit
    @route = Route.find params[:id]
  end

  def update
    new_route_name = params[:route][:name]

    route = current_user.routes.find params[:id]
    route.update_attribute( :name, new_route_name ) if route

    flash.alert = "Route '#{route.name}' updated"
    respond_to do |format|
      format.html { redirect_to :action => :index and return }
      format.json { render json: route }
    end
  end

  def destroy
    route = current_user.routes.find params[:id]
    flash.alert = "Route '#{route.name}' deleted." if route.destroy

    respond_to do |format|
      format.html { redirect_to :action => :index and return }
      format.json { head :ok }
    end
  end

end
