class DiscountStrategy
  def initialize(product:, quantity:, discount:)
    raise ArgumentError, "Product cannot be nil" if product.nil?
    raise ArgumentError, "Quantity cannot be nil" if quantity.nil?
    raise ArgumentError, "Discount cannot be nil" if discount.nil?

    @product = product
    @quantity = quantity
    @discount = discount
  end

  def apply_discount
    raise NotImplementedError, "Not implemented yet"
  end
end
