# Provides helpers for request specs
module RequestSpecHelper
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def base_headers
    { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  def auth_headers(auth)
    base_headers.merge('Authorization' => "Bearer #{auth[:token]}")
  end

  def sign_in!(user = create(:user))
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    { user: user, token: token }
  end
end
