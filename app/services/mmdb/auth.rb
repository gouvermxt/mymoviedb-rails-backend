module MMDB
  # Handle authentication process
  class Auth
    def initialize(user)
      @user = user
    end

    def start_sign_in
      token = token_provider.token
      AuthMailer.sign_in_mail(@user, token).deliver_later
    end

    private

    def token_provider
      @token_provider ||= Knock::AuthToken.new(payload: { sub: @user.id })
    end
  end
end