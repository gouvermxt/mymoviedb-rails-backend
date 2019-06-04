# Defines a generic response
module ApiResponse
  def json(command, ok_status: 200, error_status: 400)
    if command.success?
      render json: command.result, status: ok_status
    else
      render json: command.errors, status: error_status
    end
  end
end
