class RoutesController < ApplicationController

  before_filter :verify_loged_in

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
    route_name = params[:route][:name]

    @route = Route.create! :name => route_name, :user_id => current_user.id

    respond_to do |format|
      format.html { redirect_to :action => :index and return }
      format.json { render :json => @route }
    end
  end

  def edit
    @route = Route.find params[:id]
  end

  def update
    new_route_name = params[:route][:name]

    @route = Route.find_by_id_and_user_id! params[:id], current_user.id
    @route.update_attribute( :name, new_route_name ) if @route

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

end
