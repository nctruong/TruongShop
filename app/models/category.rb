class Category < ActiveRecord::Base
  has_many :products

  validates :name, presence: true, length: {maximum: 250}
end
