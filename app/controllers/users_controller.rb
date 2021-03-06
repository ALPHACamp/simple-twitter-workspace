class UsersController < ApplicationController
  before_action :setup_user, except: :tweets

  def tweets
    @user = User.includes(:tweets).find(params[:id])
    @tweets = @user.tweets
  end

  def edit
    redirect_to tweets_user_path(@user) unless @user == current_user
  end

  def update
    if @user.update(user_params)
      flash[:notice]="更新成功"
      redirect_to tweets_user_path(@user)
    else
      render :action => :edit
    end
  end

  def followings
    # @followings = @user.followings.order('created_at DESC')
    @followings = @user.followships.order('created_at DESC')
  end

  def followers
    @followings = @user.inverse_followships.order('created_at DESC')
    # @followers = @user.followers.order('created_at DESC')
  end

  def likes
    @likes = @user.likes.order(created_at: :desc)
    # @likes = @user.liked_tweets.order('created_at DESC')
  end

  private

  def setup_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar, :introduction)
  end
end
