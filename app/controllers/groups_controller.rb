class GroupsController < ActionController::Base
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      flash[:notice] = "Group added!"
      redirect_to @group
    else
      flash[:errors] = @group.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(
    :name,
    :description
    ).merge(user_id: current_user.id)
  end
end
