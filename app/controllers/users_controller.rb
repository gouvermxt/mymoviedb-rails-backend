# Application users API
class UsersController < ApplicationController
  skip_before_action :authenticate_user

  def create
    command = MMDB::Commands::CreateUser.call(user_params)
    json(command, serializer: UserSerializer, ok_status: 201)
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
