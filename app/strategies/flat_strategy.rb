class FlatStrategy < DiscountStrategy
  def apply_discount
    return 0.0 if @quantity < @discount.quantity

    @discount.discount
  end
end
