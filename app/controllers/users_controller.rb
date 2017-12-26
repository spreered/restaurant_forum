class UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @commented_restaurants = @user.restaurants.uniq
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

  private 
  def user_params
    params.require(:user).permit(:name,:intro,:avatar)
  end

end
