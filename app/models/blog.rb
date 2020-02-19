class Blog < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  belongs_to :user
end
