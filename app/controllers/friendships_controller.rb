class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(addfriend_id: params[:addfriend_id])
    if @friendship.save
      flash[:notice] = "send a friend request"
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendships = current_user.friendships.where(addfriend_id:params[:id])
    if @friendships.length > 0
      @friendships.destroy_all
      flash[:alert] = "Unfriend!"
    else
      flash[:alert] = "醒醒吧你沒朋友"
    end
    redirect_back(fallback_location: root_path)
  end
end
