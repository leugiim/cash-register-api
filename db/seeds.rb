# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

products = [{ id: "GR1", name: "Green Tea", price: 3.11 },
            { id: "SR1", name: "Strawberries", price: 5.00 },
            { id: "CF1", name: "Coffee", price: 11.23 }]

products.each do |product|
  ProductService.create!(params: product)
end

discounts = [{ product_id: "GR1", strategy: "NxM", quantity: 2, discount: 1 },
             { product_id: "SR1", strategy: "Flat", quantity: 3, discount: 4.50 },
             { product_id: "CF1", strategy: "Percent", quantity: 3, discount: 0.33 }]

discounts.each do |discount|
  DiscountService.create!(params: discount)
end
