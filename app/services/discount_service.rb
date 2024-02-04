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

  def self.calc_discount(product:, quantity:)
    total_discount = 0.0
    Discount.by_product(product).each do |discount|
      total_discount += "::#{discount.strategy}Strategy"
                        .constantize
                        .new(product:, quantity:, discount:)
                        .apply_discount
    end
    total_discount.round(2)
  end
end
