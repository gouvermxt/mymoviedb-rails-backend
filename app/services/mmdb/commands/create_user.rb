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
          user = User.create(@user_params)
          
          if user.persisted?
            MMDB::Auth.new(user).start_sign_in
            user
          else
            errors.add(:errors, user.errors.full_messages)
          end
        end
      end
    end
  end
end