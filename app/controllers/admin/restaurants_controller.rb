class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_restaurants, only: [:show,:edit,:update, :destroy]
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

  end

  def edit

  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant was successfully updated"
      redirect_to admin_restaurants_path(@restaurant)
    else
      flash[:alert] = "restaurant was failed to update"
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path
    flash[:alert] = "restaurant was deleted"
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

    def set_restaurants
      @restaurant = Restaurant.find(params[:id])
    end

end
