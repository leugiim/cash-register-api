class NxMStrategy < DiscountStrategy
  def apply_discount
    (@quantity / @discount.quantity) * (@discount.quantity - @discount.discount) * @product.price
  end
end
