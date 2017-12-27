class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
  delegate :name,to: :category,prefix: true, allow_nil: true

  belongs_to :category , optional: true 
  has_many :comments , dependent: :destroy
end
