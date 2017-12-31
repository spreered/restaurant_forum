class CreateFollowships < ActiveRecord::Migration[5.1]
  def change
    create_table :followships do |t|
      t.string :user_id
      t.string :following_id
      t.timestamps
    end
  end
end
