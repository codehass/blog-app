class RenameUsersToUser < ActiveRecord::Migration[7.0]
  def change
    rename_table :Users, :User
  end
end
