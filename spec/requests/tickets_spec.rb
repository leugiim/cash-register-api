require 'swagger_helper'

RSpec.describe 'tickets', type: :request do
  let(:id) { 1 }
  let(:total_price) { 129.99 }
  let(:products_ids) { { products_ids: 'GR1,CF1,SR1,CF1,CF1' } }
  let(:tea) { Product.new({ id: "GR1", name: "Green Tea", price: 3.11 }) }
  let(:strawberries) { Product.new({ id: "SR1", name: "Strawberries", price: 5.00 }) }
  let(:coffee) { Product.new({ id: "CF1", name: "Coffee", price: 11.23 }) }
  let(:ticket) { Ticket.new({ id:, total_price: }) }

  before do
    allow(Ticket).to receive(:find).with(1).and_return(ticket)
    allow_any_instance_of(Ticket).to receive(:save!).and_return(true)
    allow(Product).to receive(:find).with('GR1').and_return(tea)
    allow(Product).to receive(:find).with('SR1').and_return(strawberries)
    allow(Product).to receive(:find).with('CF1').and_return(coffee)
  end

  path '/tickets' do
    get('list tickets') do
      tags 'Tickets'
      response(200, 'successful') do
        run_test!
      end
    end

    post('create ticket') do
      tags 'Tickets'
      consumes 'application/json'
      parameter name: :products_ids, in: :body, schema: {
        type: :object,
        properties: {
          products_ids: { type: :string }
        },
        required: ['products_ids']
      }

      response(201, 'successful') do
        run_test!
      end
    end
  end

  path '/tickets/preview' do
    post('preview ticket') do
      tags 'Tickets'
      consumes 'application/json'
      parameter name: :products_ids, in: :body, schema: {
        type: :object,
        properties: {
          products_ids: { type: :string }
        },
        required: ['products_ids']
      }

      response(200, 'successful') do
        run_test!
      end
    end
  end

  path '/tickets/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show ticket') do
      tags 'Tickets'
      response(200, 'successful') do
        run_test!
      end
    end
  end
end
