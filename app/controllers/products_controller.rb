class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  # GET /products
  def index
    render json: ProductService.all
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = ProductService.create!(params: product_params)

    if @product.errors.any?
      render json: @product.errors, status: :unprocessable_entity
    else
      render json: @product, status: :created, location: @product
    end
  end

  # PATCH/PUT /products/1
  def update
    @product = ProductService.update!(product: @product, params: product_params)

    if @product.errors.any?
      render json: @product.errors, status: :unprocessable_entity
    else
      render json: @product
    end
  end

  # DELETE /products/1
  def destroy
    ProductService.destroy!(product: @product)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = ProductService.get(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.permit(:id, :name, :price)
  end
end
