class Api::V1::GroupsController < Api::V1::ApiController

  skip_before_action :authenticate_coach_from_token

  def index
    @groups = Group.all

    respond_with @groups, location: ''
  end

  def show
    @group = Group.find_by(id: params[:id])

    respond_with @group, location: ''
  end

  def create
    # @group = current_coach.groups.create group_params
    @group = Coach.first.groups.create group_params

    respond_with @group, location: ''
  end

  private

    def group_params
      params.require(:group).permit(:name, :description)
    end

end
