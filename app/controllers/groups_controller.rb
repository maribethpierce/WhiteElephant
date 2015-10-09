class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @groups = Group.where(user: @user)
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @user = current_user
    @group.users << current_user
    if @group.save
      flash[:notice] = "Group added!"
      redirect_to user_groups_path
    else
      flash[:errors] = @group.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    @names = []
    @group.users.each do |user|
      @names << user.name
    end
  end

  def update
    @group = Group.find(params[:id])
    @user = current_user
    @users = User.all
    # user_params.each do |user|
    #   @group.users << user
    # end
    if @group.update(group_params)
      flash[:notice] = "Members added!"
      redirect_to user_group_path(@user, @group)
    else
      flash[:errors] = @memberships.errors.full_messages.join('. ')
      redirect_to user_group_path(@user, @group)
    end
  end

  private

  def group_params
    params.require(:group).permit(
    :name,
    :description,
    user_ids: []
    ).merge(user_id: current_user.id)
  end

  # def user_params
  #   params.require(:group).permit(:user_id)
  # end

end
