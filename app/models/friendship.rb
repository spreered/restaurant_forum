class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :addfriend, class_name: "User"
  validates :addfirend_id, uniqueness: {scope: :user_id}
end
