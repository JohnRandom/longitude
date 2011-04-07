class LocationsController < ApplicationController
  before_filter :verify_loged_in

  def new
    @location = Location.new
  end

  def create
    route = Route.find params[:id]
    @location = route.locations.create latitude => params[:latitude], longitude => params[:longitude]

    flash.now.alert = "Location '#{location.name}' created"
    render :new
  end
end
