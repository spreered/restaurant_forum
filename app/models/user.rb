class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :default_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants , through: :comments
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant
  has_many :followships, dependent: :destroy   #追蹤關係
  has_many :followings, through: :followships  #追蹤對象
  has_many :inverse_followships, class_name:"Followship", foreign_key: "following_id"  #反向的追蹤關係 fk設定following_id
  has_many :followers ,through: :inverse_followships, source: :user

  def admin?
    self.role == "admin"
  end

  def default_name
    if self.name==""
      self.name = self.email.split('@')[0]
    end
  end

  def following?(user)
    self.followings.include?(user)
  end

end
