class Api::V1::GroupsController < Api::V1::ApiController

  before_action :fetch_group

  def index
    @groups = current_coach.groups

    respond_with @groups, location: ''
  end

  def show
    respond_with @group, location: ''
  end

  def create
    @group = current_coach.groups.create group_params

    respond_with @group, location: ''
  end

  def average_results
    @result = Vo2MaxAverage.new(trainings: @group.trainings, title: @group.name, range: 15.day).call

    respond_with @result, location: ''
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

  def fetch_group
    @group = current_coach.groups.find_by(id: params[:id])
  end

end
