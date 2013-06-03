class Order < ActiveRecord::Base
  attr_accessible :name, :email, :phone, :address, :total, :created_at

  before_save { |order| order.email = email.downcase }
  before_save { self.created_at = DateTime.now}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, length: { minimum: 3}
  validates :phone, presence: true, length: { minimum: 8, maximum: 14 }
  validates :address, presence: true

    def find_by_date(date)
      start_time = DateTime.new(date.year, date.month, date.day, 0, 0, 0)
      end_time = DateTime.new(date.year, date.month, date.day, 23, 59, 59)
      Order.where("created_at > ? AND created_at < ?", start_time, end_time)
    end

end
