class AddConfirmedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :confirmed_at, :datetime, default: nil
  end
end
