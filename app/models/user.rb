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
  has_many :friendships, dependent: :destroy #交友關係
  has_many :addfriends, through: :friendships #加入好友
  has_many :inverse_friendships, class_name:"Friendship", foreign_key: "addfriend_id"  #反向的交友關係 fk為addfriend_id
  has_many :friendrequests, through: :inverse_friendships, source: :user #加我好友的人

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

  def addfriend?(user)
    self.addfriends.include?(user)
  end

  def all_friends
    friends = []
    #要先new 一個array出來，直接assign可能會覆寫到原陣列
    friends.concat(self.addfriends)
    #陣列串連不能用push 或 << 
    friends.concat(self.friendrequests)
    friends = friends.uniq
    return friends
  end
  def friends_list
    list = []
    self.addfriends.each do |addfriend|
      list<<addfriend if self.friendrequests.include?(addfriend)
    end
    return list
  end 
end
