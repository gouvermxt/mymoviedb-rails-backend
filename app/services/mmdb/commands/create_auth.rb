module MMDB
  module Commands
    class CreateAuth
      prepend SimpleCommand

      def initialize(auth_params)
        @email = auth_params[:email]
      end

      def call
        user = User.find_by(email: @email)

        if user
          MMDB::Auth.new(user).start_sign_in
        else
          errors.add(:errors, I18n.t('errors.user_not_found'))
        end
      end
    end
  end
end
