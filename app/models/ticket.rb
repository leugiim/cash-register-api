class Ticket < ApplicationRecord
  has_many :ticket_details
  accepts_nested_attributes_for :ticket_details

  validates :price, numericality: { greater_than: 0 }, presence: true
  validates :discount, numericality: { greater_than: 0 }, presence: true
  validates :total_price, numericality: { greater_than: 0 }, presence: true

  def as_json(options = {})
    super(options.merge(include: { ticket_details: { except: [:created_at, :updated_at] } }))
  end
end
