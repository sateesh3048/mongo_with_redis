class UsersController < ApplicationController

  # before_filter :user_params, on: :edit


  def index
    @users = User.order(name: :desc).page params[:page]
  end


  def edit
    @user = User.find(id: params[:id])
  end

  def update
    @user = User.find(id: params[:id])
    @user.update_attributes(user_params)
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:image)
  end
end
