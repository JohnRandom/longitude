class LocationsController < ApplicationController
  before_filter :verify_loged_in

  respond_to :html, :json

  def new
    @route = Route.find params[:route_id]
    @location = Location.new
  end

  def index
    @route = current_user.routes.find params[:route_id]
    @locations = @route.locations

    respond_to do |format|
      format.html
      format.json { render :json => @locations }
    end
  end

  def show
    @route = current_user.routes.find params[:route_id]
    @location = @route.locations.find params[:id]

    respond_to do |format|
      format.html
      format.json { render :json => @location }
    end
  end

  def create
    @route = current_user.routes.find params[:route_id]
    @location = @route.locations.create params[:location]

    flash.alert = "Location '#{@location.latitude}:#{@location.longitude}' on '#{@route.name}' created"
    respond_to do |format|
      format.html { redirect_to edit_route_url(@route) }
      format.json { render :json => @location }
    end
  end

  def destroy
    route = current_user.routes.find params[:route_id]
    location = route.locations.find params[:id]

    flash.alert = "Location deleted." if location.destroy
    respond_to do |format|
      format.html { redirect_to edit_route_url(params[:route_id]) and return }
      format.json { head :ok }
    end
  end
end
