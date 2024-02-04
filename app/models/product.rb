class Product < ApplicationRecord
  has_many :ticket_details
  has_many :discounts

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }, presence: true
end
