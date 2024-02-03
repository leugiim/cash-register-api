class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }, presence: true
end
