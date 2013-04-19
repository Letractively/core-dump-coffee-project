class Order < ActiveRecord::Base
  attr_accessible :name, :email, :phone, :address, :total

  before_save { |order| order.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, length: { minimum: 3}
  validates :phone, presence: true, length: { minimum: 8, maximum: 14 }
  validates :address, presence: true
end
