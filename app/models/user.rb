class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :default_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader

  has_many :comments
  def admin?
    self.role == "admin"
  end
  def default_name
    if self.name==""
      self.name = self.email.split('@')[0]
    end
  end

end
