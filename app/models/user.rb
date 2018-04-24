class User < ApplicationRecord
  before_save :mail_downcase
  validates :name, presence: true, length: {maximum: Setting.max_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Setting.max_mail},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Setting.min_pass}

  private
  def mail_downcase
    mail.downcase!
  end
end
