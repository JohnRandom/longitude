class LocationsController < ApplicationController
  before_filter :verify_loged_in

  def new
    @route = Route.find params[:route_id]
    @location = Location.new
  end

  def create
    @route = Route.find params[:route_id]
    @location = @route.locations.create! :latitude => params[:location][:latitude], :longitude => params[:location][:longitude]

    flash.now.alert = "Location '#{@location.latitude}:#{@location.longitude}' on '#{@route.name}' created"
    redirect_to edit_route_url(@route)
  end
end
