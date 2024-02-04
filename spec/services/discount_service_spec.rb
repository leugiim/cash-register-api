require 'rails_helper'

RSpec.describe DiscountService, type: :model do
  describe '.calc_discount' do
    let(:tea) { Product.new({ id: "GR1", name: "Green Tea", price: 3.11 }) }
    let(:tea_discount) { Discount.new(strategy: 'NxM', quantity: 2, discount: 1.0) }
    let(:strawberries) { Product.new({ id: "SR1", name: "Strawberries", price: 5.00 }) }
    let(:strawberries_discount) { Discount.new(strategy: 'Flat', quantity: 3, discount: 4.5) }
    let(:coffee) { Product.new({ id: "CF1", name: "Coffee", price: 11.23 }) }
    let(:coffee_discount) { Discount.new(strategy: 'Percent', quantity: 3, discount: 0.3333333) }

    before do
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

    describe 'calculates discount for tea product with NxMStrategy' do
      let(:product) { tea }

      describe 'with 2x1' do
        it 'and [0-6] products' do
          expect(DiscountService.calc_discount(product:, quantity: 0)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 1)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 2)).to eq(3.11)
          expect(DiscountService.calc_discount(product:, quantity: 3)).to eq(3.11)
          expect(DiscountService.calc_discount(product:, quantity: 4)).to eq(6.22)
          expect(DiscountService.calc_discount(product:, quantity: 5)).to eq(6.22)
          expect(DiscountService.calc_discount(product:, quantity: 6)).to eq(9.33)
        end
      end

      describe 'with 3x2' do
        let(:tea_discount) { Discount.new(strategy: 'NxM', quantity: 3, discount: 2.0) }

        it 'and [0-6] products' do
          expect(DiscountService.calc_discount(product:, quantity: 0)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 1)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 2)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 3)).to eq(3.11)
          expect(DiscountService.calc_discount(product:, quantity: 4)).to eq(3.11)
          expect(DiscountService.calc_discount(product:, quantity: 5)).to eq(3.11)
          expect(DiscountService.calc_discount(product:, quantity: 6)).to eq(6.22)
        end
      end
    end

    describe 'calculates discount for strawberries product with FlatStrategy' do
      let(:product) { strawberries }

      describe 'with quantity 3 and discount 4.5' do
        it 'and [0-6] products' do
          expect(DiscountService.calc_discount(product:, quantity: 0)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 1)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 2)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 3)).to eq(4.5)
          expect(DiscountService.calc_discount(product:, quantity: 4)).to eq(4.5)
          expect(DiscountService.calc_discount(product:, quantity: 5)).to eq(4.5)
          expect(DiscountService.calc_discount(product:, quantity: 6)).to eq(4.5)
        end
      end

      describe 'with quantity 2 and discount 2.5' do
        let(:strawberries_discount) { Discount.new(strategy: 'Flat', quantity: 2, discount: 2.5) }

        it 'and [0-6] products' do
          expect(DiscountService.calc_discount(product:, quantity: 0)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 1)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 2)).to eq(2.5)
          expect(DiscountService.calc_discount(product:, quantity: 3)).to eq(2.5)
          expect(DiscountService.calc_discount(product:, quantity: 4)).to eq(2.5)
          expect(DiscountService.calc_discount(product:, quantity: 5)).to eq(2.5)
          expect(DiscountService.calc_discount(product:, quantity: 6)).to eq(2.5)
        end
      end
    end

    describe 'calculates discount for coffee product with PercentStrategy' do
      let(:product) { coffee }

      describe 'with quantity 3 and discount 33.33333%' do
        it 'and [0-6] products' do
          expect(DiscountService.calc_discount(product:, quantity: 0)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 1)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 2)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 3)).to eq(11.23)
          expect(DiscountService.calc_discount(product:, quantity: 4)).to eq(14.97)
          expect(DiscountService.calc_discount(product:, quantity: 5)).to eq(18.72)
          expect(DiscountService.calc_discount(product:, quantity: 6)).to eq(22.46)
        end
      end

      describe 'with quantity 5 and discount 50%' do
        let(:coffee_discount) { Discount.new(strategy: 'Percent', quantity: 5, discount: 0.5) }

        it 'and [0-6] products' do
          expect(DiscountService.calc_discount(product:, quantity: 0)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 1)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 2)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 3)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 4)).to eq(0.0)
          expect(DiscountService.calc_discount(product:, quantity: 5)).to eq(28.08)
          expect(DiscountService.calc_discount(product:, quantity: 6)).to eq(33.69)
        end
      end
    end

    describe 'returns 0.0 when no discounts are available' do
      let(:product) { tea }
      let(:quantity) { 5 }

      before { allow(Discount).to receive(:by_product).with(product).and_return([]) }

      it do
        result = DiscountService.calc_discount(product:, quantity:)

        expect(result).to eq(0.0)
      end
    end
  end
end
