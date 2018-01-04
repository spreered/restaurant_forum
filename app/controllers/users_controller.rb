class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user=User.find(params[:id])
    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants
    @followings = @user.followings
    @followers = @user.followers
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.save
    redirect_to user_path(@user)
  end

  def friend_list
    @user = User.find(params[:id])
    # @all_friends = @user.all_friends
    @all_friends = @user.friends_list
    @addfriends = @user.addfriends
    @friendrequests = @user.friendrequests
  end

  private 
  def user_params
    params.require(:user).permit(:name,:intro,:avatar)
  end

end
