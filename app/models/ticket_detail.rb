class TicketDetail < ApplicationRecord
  belongs_to :ticket
  belongs_to :product

  validates :product_name, presence: true
  validates :quantity, numericality: { greater_than: 0 }, presence: true
  validates :price_per_unit, numericality: { greater_than: 0 }, presence: true
  validates :price, numericality: { greater_than: 0 }, presence: true
  validates :discount, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :total_price, numericality: { greater_than: 0 }, presence: true
end
