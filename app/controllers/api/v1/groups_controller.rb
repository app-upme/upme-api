class Api::V1::GroupsController < Api::V1::ApiController

  def index
    @groups = Group.all

    respond_with @groups, location: ''
  end

end
