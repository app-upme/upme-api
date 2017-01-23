class Api::V1::GroupsController < Api::V1::ApiController

  def index
    @groups = Group.all

    respond_with @groups, location: ''
  end

  def create
    @group = current_coach.groups.create group_params

    respond_with @group, location: ''
  end

  private

    def group_params
      params.permit(:name, :description)
    end

end
