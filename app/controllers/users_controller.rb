# Application users API
class UsersController < ApplicationController
  def create
    command = MMDB::Commands::CreateUser.call(user_params)
    json(command, serializer: UserSerializer, ok_status: 201)
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
