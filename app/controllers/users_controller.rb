class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @groups = Group.where(user: @user)
    # binding.pry
  end

  def destroy
    @user = User.find(params[:id])
    if current_user != @user
      flash[:errors] = "You're not allowed to delete others!"
      redirect_to groups_path
    else
      @user.destroy
      flash[:success] = "Account deleted!"
      redirect_to root_path
    end
  end
end
