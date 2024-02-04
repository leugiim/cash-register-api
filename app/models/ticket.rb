class Ticket < ApplicationRecord
  has_many :ticket_details
  accepts_nested_attributes_for :ticket_details

  def as_json(options = {})
    super(options.merge(include: { ticket_details: { except: [:created_at, :updated_at] } }))
  end
end
