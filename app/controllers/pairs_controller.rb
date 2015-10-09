class PairsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @santas = @group.users
    @recipients = @group.users
    def mix(a, b)
      @matches = Hash[a.zip b.shuffle]
      @matches.each do |key, value|
        if key == value
          mix(a, b)
        end
      end
      return @matches
    end
    return @matches
  end

end
