# Top level API controller
class ApplicationController < ActionController::API
  include ApiResponse
  include Knock::Authenticable

  before_action :authenticate_user
end
