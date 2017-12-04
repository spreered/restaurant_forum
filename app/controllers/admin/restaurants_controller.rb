class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  def index
    @restaurants = Restaurant.all
  end

  def new 
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "Restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash[:alert] = "Restaurant was failed to creat"
      render :new
    end
  end

  def show 
    @restaurant = Restaurant.find(params[:id])
  end

  private
    def authenticate_admin
      unless current_user.admin?
        flash[:alert] = "Not allow"
        redirect_to root_path
      end
    end

    def restaurant_params
      params.require(:restaurant).permit(:name,:tel,:address,:opening_hours,:description)
    end

end
