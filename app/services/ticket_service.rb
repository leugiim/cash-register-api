class TicketService
  def self.all
    Ticket.all
  end

  def self.get(id:)
    Ticket.find(id.to_i)
  end

  def self.create!(params:)
    ticket = preview(params:)
    ticket.save!
    ticket
  end

  def self.preview(params:)
    products_ids = params[:products_ids].split(",")
    ticket = Ticket.new({ price: 0,
                          discount: 0,
                          total_price: 0 })

    products_ids
      .each_with_object(Hash.new(0)) { |id, hash| hash[id] += 1 }
      .each { |product_id, quantity| add_ticket_detail(ticket:, product_id:, quantity:) }

    ticket
  end

  def self.add_ticket_detail(ticket:, product_id:, quantity:)
    product = ProductService.get(id: product_id)
    discount = DiscountService.calc_discount(product:, quantity:)

    ticket_detail = create_ticket_detail(ticket:, product:, quantity:, discount:)

    ticket.price += ticket_detail.price
    ticket.discount += ticket_detail.discount
    ticket.total_price += ticket_detail.total_price
  end

  def self.create_ticket_detail(ticket:, product:, quantity:, discount:)
    ticket.ticket_details.build(
      product_id: product.id,
      product_name: product.name,
      quantity:,
      price_per_unit: product.price,
      price: product.price * quantity,
      discount:,
      total_price: (product.price * quantity - discount).round(2)
    )
  end
end
