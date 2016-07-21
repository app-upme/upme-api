class Api::V1::Coaches::RegistrationsController < DeviseTokenAuth::RegistrationsController

  def sign_up_params
    params.permit(:name, :email, :password, :avatar)
  end

end



