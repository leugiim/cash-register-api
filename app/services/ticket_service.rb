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
    ticket = Ticket.new({ total_price: 0 })

    products_ids
      .each_with_object(Hash.new(0)) { |id, hash| hash[id] += 1 }
      .each do |product_id, quantity|
        product = ProductService.get(id: product_id)
        ticket_detail = create_ticket_detail(ticket:, product:, quantity:)
        ticket.total_price += ticket_detail.total_price
      end
    ticket
  end

  def self.create_ticket_detail(ticket:, product:, quantity:)
    ticket.ticket_details.build(
      product_id: product.id,
      product_name: product.name,
      quantity:,
      price_per_unit: product.price,
      total_price: product.price * quantity
    )
  end
end
