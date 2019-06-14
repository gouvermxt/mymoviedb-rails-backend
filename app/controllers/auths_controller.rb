# Handles the Authentication API
class AuthsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    command = MMDB::Commands::CreateAuth.call(auth_params)
    json(command, ok_status: 201, error_status: 404)
  end

  private

  def auth_params
    params.permit(:email)
  end
end
