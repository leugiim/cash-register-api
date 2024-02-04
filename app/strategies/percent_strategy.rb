class PercentStrategy < DiscountStrategy
  def apply_discount
    return 0.0 if @quantity < @discount.quantity

    @quantity * @product.price * @discount.discount
  end
end
