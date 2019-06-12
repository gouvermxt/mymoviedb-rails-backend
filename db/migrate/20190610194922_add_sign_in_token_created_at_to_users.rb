class AddSignInTokenCreatedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sign_in_token_created_at, :datetime
  end
end
