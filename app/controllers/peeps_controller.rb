class PeepsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.find(params[:group_id])
  end

  def create
    @user = current_user
    @group = Group.find(params[:group_id])
    @peep = Peep.new(peeps_params)
    @peep.group = @group
    if @peep.save
      flash[:notice] = "Success! Your peep(s) were added."
      redirect_to user_groups_path
    else
      flash[:errors] = @peep.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  def update
    @group = Group.find(params[:id])
    @user = User.find(params[:id])
    @peeps = Peep.all
    @peep = Peep.create(@group, peeps_params)
  end

  private

  def peeps_params
    params.require(:peep).permit(:name, :email)
  end
end
