# Defines a generic response
module ApiResponse
  def json(command, ok_status: 200, error_status: 400, serializer:, view: nil)
    if command.success?
      render(
        json: serializer.render(command.result, view: view),
        status: ok_status
      )
    else
      render json: command.errors, status: error_status
    end
  end
end
