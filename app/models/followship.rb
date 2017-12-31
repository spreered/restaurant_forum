class Followship < ApplicationRecord
  belong_to :user
  belong_to :following, class_name: "User"
  validates :following_id, uniqueness: {scope: :user_id}
end
