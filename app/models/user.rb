class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.email_regex
  before_save {email.downcase!}

  validates :name, presence: true, length: { maximum: Settings.name_length }
  validates :email, presence: true, length: { maximum: Settings.email_length }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: Settings.pass_min_length }

  has_secure_password

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
  end
end
