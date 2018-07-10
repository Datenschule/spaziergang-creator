class AddUserIdToWalks < ActiveRecord::Migration[5.2]
  def change
    add_column :walks, :user_id, :integer
  end
end
