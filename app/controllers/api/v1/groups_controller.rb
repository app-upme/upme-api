class Api::V1::GroupsController < Api::V1::ApiController

  skip_before_action :authenticate_coach!

  def index
    @groups = Group.all

    respond_with @groups, location: ''
  end

end
