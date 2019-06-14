module MMDB
  module Commands
    class ShowCurrentUser
      prepend SimpleCommand

      def initialize(current_user)
        @current_user = current_user
      end

      # Confirms the user on first access
      def call 
        @current_user.update(confirmed_at: Time.current) unless(
          @current_user.confirmed_at.present?
        )

        @current_user
      end
    end
  end
end