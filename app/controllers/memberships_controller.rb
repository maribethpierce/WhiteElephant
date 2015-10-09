class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.find(params[:group_id])
    @users = User.all
    # @membership = Membership.new
  end

  def create
    @user = current_user
    @group = Group.find(params[:group_id])
    @membership = Membership.new(user_params)
    @membership.group = @group
    if @membership.save
      flash[:notice] = "Success! Members added."
      redirect_to user_groups_path
    else
      flash[:errors] = @membership.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @santas = Membership.find(params[:group_id])
    @recipients = Membership.find(params[:group_id])
    @pairs = Pairs.new(pair_params)
    if @pairs.save
      flash[:notice] = "Success! Pairings created!"
      redirect_to user_groups_path
    else
      flash[:errors] = @pairs.errors.full_messages.join(', ')
      render :edit
    end
  end

  def update
    @group = Group.find(params[:id])
    @user = User.find(params[:id])
    @users = User.all
    @membership = Membership.create(@group, user_params)
  end

  private

  def user_params
    params.require(:membership).permit(:user_id)
  end
end
