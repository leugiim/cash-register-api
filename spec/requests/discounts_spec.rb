require 'swagger_helper'

RSpec.describe 'discounts', type: :request do
  let(:id) { "1" }
  let(:product_id) { 'GR1' }
  let(:strategy) { 'NxM' }
  let(:quantity) { 2 }
  let(:disc) { 1.0 }
  let(:name) { 'Amazing Product' }
  let(:price) { 29.99 }
  let(:product) { Product.new({ id: product_id, name:, price: }) }
  let(:discount) { Discount.new({ id:, product_id:, strategy:, quantity:, discount: disc }) }

  before do
    allow(Discount).to receive(:find).with("1").and_return(discount)
    allow(Product).to receive(:find).with("GR1").and_return(product)
    allow_any_instance_of(Discount).to receive(:save!).and_return(true)
  end

  path '/discounts' do
    get('list discounts') do
      tags 'Discounts'
      response(200, 'successful') do
        run_test!
      end
    end

    post('create discount') do
      tags 'Discounts'
      consumes 'application/json'
      parameter name: :discount, in: :body, schema: {
        type: :object,
        properties: {
          product_id: { type: :string },
          strategy: { type: :string },
          quantity: { type: :number },
          discount: { type: :number }
        },
        required: %w[product_id strategy quantity discount]
      }

      response(201, 'successful') do
        run_test!
      end
    end
  end

  path '/discounts/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show discount') do
      tags 'Discounts'
      response(200, 'successful') do
        run_test!
      end
    end

    patch('update discount') do
      tags 'Discounts'
      consumes 'application/json'
      parameter name: :discount, in: :body, schema: {
        type: :object,
        properties: {
          product_id: { type: :string },
          strategy: { type: :string },
          quantity: { type: :number },
          discount: { type: :number }
        }
      }

      response(200, 'successful') do
        run_test!
      end
    end

    put('update discount') do
      tags 'Discounts'
      consumes 'application/json'
      parameter name: :discount, in: :body, schema: {
        type: :object,
        properties: {
          product_id: { type: :string },
          strategy: { type: :string },
          quantity: { type: :number },
          discount: { type: :number }
        }
      }

      response(200, 'successful') do
        run_test!
      end
    end

    delete('delete discount') do
      tags 'Discounts'
      response(202, 'successful') do
        run_test!
      end
    end
  end
end
