class RemoveSignInTokenFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :sign_in_token, :string
    remove_column :users, :sign_in_token_created_at, :datetime
  end
end
