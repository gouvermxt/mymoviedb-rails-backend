# Handles the authenticated user API
class CurrentUsersController < ApplicationController
  def show
    command = MMDB::Commands::ShowCurrentUser.call(current_user)
    json(command, serializer: UserSerializer)
  end
end
