class Discount < ApplicationRecord
  belongs_to :product

  validates :strategy, inclusion: { in: %w[NxM Flat Percent] }
  validates :quantity, numericality: { greater_than: 0 }, presence: true
  validates :discount, numericality: { greater_than: 0 }, presence: true

  scope :by_product, ->(product) { where(product:) }
end
