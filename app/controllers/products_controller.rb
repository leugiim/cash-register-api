class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  # GET /products
  def index
    json json: ProductService.all
  rescue StandardError => e
    error json: e.expection, status: :internal_server_error
  end

  # GET /products/1
  def show
    json json: @product
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  # POST /products
  def create
    @product = ProductService.create!(params: product_params)

    if @product.errors.any?
      error json: @product.errors, status: :unprocessable_entity
    else
      json json: @product, status: :created, location: @product
    end
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  # PATCH/PUT /products/1
  def update
    @product = ProductService.update!(product: @product, params: product_params)

    if @product.errors.any?
      error json: @product.errors, status: :unprocessable_entity
    else
      json json: @product
    end
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  # DELETE /products/1
  def destroy
    ProductService.destroy!(product: @product)

    json json: nil, status: :accepted
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = ProductService.get(id: params[:id])
  rescue ActiveRecord::RecordNotFound => e
    error json: e.message, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.permit(:id, :name, :price)
  end
end
