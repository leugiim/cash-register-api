class DiscountService
  def self.all
    Discount.all
  end

  def self.get(id:)
    Discount.find(id)
  end

  def self.create!(params:)
    discount = Discount.new(params)
    discount.save!
    discount
  end

  def self.update!(discount:, params:)
    discount.update!(params)
    discount
  end

  def self.destroy!(discount:)
    discount.destroy!
  end
end
