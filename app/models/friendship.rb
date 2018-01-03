class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :addfriend, class_name: "User"
  validates :addfriend_id, uniqueness: {scope: :user_id}
end
