class ChangeFollowshipIdType < ActiveRecord::Migration[5.1]
  def change
    change_column :followships, :user_id, :integer
    change_column :followships, :following_id, :integer
  end
end
