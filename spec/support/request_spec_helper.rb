module RequestSpecHelper
  def json
    parsed_json = JSON.parse(response.body)

    if parsed_json.is_a? Array
      parsed_json
    else
      ActiveSupport::HashWithIndifferentAccess.new(parsed_json)
    end
  end
end
