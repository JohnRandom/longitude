class LocationsController < ApplicationController
  before_filter :verify_loged_in

  respond_to :html, :json

  def new
    @route = Route.find params[:route_id]
    @location = Location.new
  end

  def create
    lat = params[:location][:latitude]
    long = params[:location][:longitude]

    @route = Route.find params[:route_id]
    @location = @route.locations.create! :latitude => lat, :longitude => long, :user_id => current_user.id

    flash.alert = "Location '#{@location.latitude}:#{@location.longitude}' on '#{@route.name}' created"
    respond_to do |format|
      format.html { redirect_to edit_route_url(@route) }
      format.json { render :json => @location }
    end
  end

  def destroy
    @location = Location.find_by_id_and_user_id params[:id], current_user.id
    @location.destroy if @location

    logger.debug "edit_route_url: #{edit_route_url params[:route_id]}"

    flash.alert = "Location deleted."
    respond_to do |format|
      format.html { redirect_to edit_route_url(params[:route_id]) and return }
      format.json { head :deleted }
    end
  end
end
