class Micropost < ApplicationRecord
  belongs_to :user

  scope :lastest, -> { order created_at: :desc }

  delegate :name, to: :user, prefix: true

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.max_content }
  validate  :picture_size

  mount_uploader :picture, PictureUploader

  private
    def picture_size
      return unless picture.size > Settings.max_img_size.megabytes
      errors.add(:picture, I18n.t("alert.max_img_size"))
    end
end
