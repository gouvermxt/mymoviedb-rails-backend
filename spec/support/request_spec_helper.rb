# Provides helpers for request specs
module RequestSpecHelper
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def base_headers
    { 'Content-Type' => 'application/json' }
  end
end
