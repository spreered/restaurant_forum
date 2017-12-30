class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
  delegate :name,to: :category,prefix: true, allow_nil: true

  belongs_to :category , optional: true 
  has_many :comments , dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  def set_favorites_count
    self.update_attributes(favorites_count: self.favorites.uniq.length) 
  end

  def self.set_all_favorites_count
    restaurants = self.all
    restaurants.each do |restaurant|
      restaurant.update_attributes(favorites_count: restaurant.favorites.uniq.length) 
    end
  end
  #使用class method計算，每次呼叫可能效能比較差
  
end
