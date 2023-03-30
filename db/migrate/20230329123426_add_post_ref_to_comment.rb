class AddPostRefToComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :post, foreign_key: { to_table: :posts }, null: false
  end
end
