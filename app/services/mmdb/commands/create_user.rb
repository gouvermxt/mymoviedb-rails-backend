module MMDB
  module Commands
    # Controller command to create a new user
    class CreateUser
      prepend SimpleCommand

      def initialize(user_params)
        @user_params = user_params
      end

      def call
        ActiveRecord::Base.transaction do
          user = create_user

          if user.persisted?
            MMDB::Auth.new(user).start_sign_in
            user
          else
            errors.add(:errors, user.errors.full_messages)
          end
        end
      end

      private

      # If an unconfirmed user with the given email already exists, destroys it
      # and tries to create a new one
      def create_user
        User.find_by(email: @user_params[:email], confirmed_at: nil)&.destroy
        User.create(@user_params)
      end
    end
  end
end
