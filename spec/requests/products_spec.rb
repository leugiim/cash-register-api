require 'swagger_helper'

RSpec.describe 'products', type: :request do
  let(:id) { 'AP1' }
  let(:name) { 'Amazing Product' }
  let(:price) { 29.99 }
  let(:product) { Product.new({ id:, name:, price: }) }

  before do
    allow(Product).to receive(:find).with("AP1").and_return(product)
  end

  path '/products' do
    get('list products') do
      tags 'Products'
      response(200, 'successful') do
        run_test!
      end
    end

    post('create product') do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :string },
          name: { type: :string },
          price: { type: :number }
        },
        required: %w[id name price]
      }

      response(201, 'successful') do
        run_test!
      end
    end
  end

  path '/products/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show product') do
      tags 'Products'
      response(200, 'successful') do
        run_test!
      end
    end

    patch('update product') do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number }
        }
      }

      response(200, 'successful') do
        run_test!
      end
    end

    put('update product') do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number }
        }
      }

      response(200, 'successful') do
        run_test!
      end
    end

    delete('delete product') do
      tags 'Products'
      response(202, 'successful') do
        run_test!
      end
    end
  end
end
