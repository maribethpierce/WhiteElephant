class PairsController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = Group.find(params[:group_id])
    @santas = @group.users
    @recipients = @group.users
  end

  def new
    @group = Group.find(params[:group_id])
    if @group.pairs.any?
      flash[:alert] = "Pairs already created for this group"
      redirect_to group_path(@group)
    else
      @pairs = Pair.new
    end
  end

  def create
    @group = Group.find(params[:group_id])
    @members = @group.users
    def mix(a)
      100.times do
        a.shuffle!
      end
      Hash[a.zip a.rotate]
    end
    @pairs = []
    @members.each do |member|
      @pairs << member
    end
    @drawing = mix(@pairs)
    # binding.pry
    @drawing.each do |key, value|
      @santa = key.id
      @recipient = value.id
      @pair = Pair.create(santa: @santa, recipient: @recipient, locked: true, group: @group)
    end
    if @pair.save
      flash[:notice] = "Success! Pairs created!"
      redirect_to group_path(@group)
    end
  end

  private

  # def pair_params
  #   params.require(:pair).permit(:user_id as :santa_id, :user_id as :recipient_id)
  # end
end
