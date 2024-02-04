require 'rails_helper'

RSpec.describe TicketService, type: :model do
  describe '.preview' do
    let(:tea) { Product.new({ id: "GR1", name: "Green Tea", price: 3.11 }) }
    let(:tea_discount) { Discount.new(strategy: 'NxM', quantity: 2, discount: 1.0) }
    let(:strawberries) { Product.new({ id: "SR1", name: "Strawberries", price: 5.00 }) }
    let(:strawberries_discount) { Discount.new(strategy: 'Flat', quantity: 3, discount: 4.5) }
    let(:coffee) { Product.new({ id: "CF1", name: "Coffee", price: 11.23 }) }
    let(:coffee_discount) { Discount.new(strategy: 'Percent', quantity: 3, discount: 0.3333333) }

    before do
      allow(Product).to receive(:find).with('GR1').and_return(tea)
      allow(Product).to receive(:find).with('SR1').and_return(strawberries)
      allow(Product).to receive(:find).with('CF1').and_return(coffee)
      allow(Discount).to receive(:by_product)
        .with(tea)
        .and_return([tea_discount])
      allow(Discount).to receive(:by_product)
        .with(strawberries)
        .and_return([strawberries_discount])
      allow(Discount).to receive(:by_product)
        .with(coffee)
        .and_return([coffee_discount])
    end

    describe 'calculates total price for cart' do
      describe 'with GR1,GR1' do
        let(:products_ids) { 'GR1,GR1' }
        it do
          ticket = TicketService.preview(params: { products_ids: })
          expect(ticket.ticket_details.size).to eq(1)
          expect(ticket.price).to eq(6.22)
          expect(ticket.discount).to eq(3.11)
          expect(ticket.total_price).to eq(3.11)
        end
      end

      describe 'with SR1,SR1,GR1,SR1' do
        let(:products_ids) { 'SR1,SR1,GR1,SR1' }
        it do
          ticket = TicketService.preview(params: { products_ids: })
          expect(ticket.ticket_details.size).to eq(2)
          expect(ticket.price).to eq(18.11)
          expect(ticket.discount).to eq(4.5)
          expect(ticket.total_price).to eq(13.61)
        end
      end

      describe 'with GR1,CF1,SR1,CF1,CF1' do
        let(:products_ids) { 'GR1,CF1,SR1,CF1,CF1' }
        it do
          ticket = TicketService.preview(params: { products_ids: })
          expect(ticket.ticket_details.size).to eq(3)
          expect(ticket.price).to eq(41.8)
          expect(ticket.discount).to eq(11.23)
          expect(ticket.total_price).to eq(30.57)
        end
      end

      describe 'with GR1,CF1,SR1' do
        let(:products_ids) { 'GR1,CF1,SR1' }
        it do
          ticket = TicketService.preview(params: { products_ids: })
          expect(ticket.ticket_details.size).to eq(3)
          expect(ticket.price).to eq(19.34)
          expect(ticket.discount).to eq(0.0)
          expect(ticket.total_price).to eq(19.34)
        end
      end
    end
  end
end
