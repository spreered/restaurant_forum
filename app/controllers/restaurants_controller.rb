class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end
  def show 
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user:current_user)
    #Favorite.create(restaurant: @restaurant, user: current_user)
    #current_user.favorites.create(restaurant: @restaurant)

    redirect_back(fallback_location: root_path) 
    #導回上一頁
    #fallback_location : 找不到上一頁預設導向位置
  end

  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    favorite = Favorite.where(restaurant: @restaurant, user: current_user)
    favorite.destroy_all
    redirect_back(fallback_location:root_path)
  end


end
