class ProductService
  def self.all
    Product.all
  end

  def self.get(id:)
    Product.find(id)
  end

  def self.create!(params:)
    product = Product.new(params)
    product.save!
    product
  end

  def self.update!(product:, params:)
    product.update!(params)
    product
  end

  def self.destroy!(product:)
    product.destroy!
  end
end
