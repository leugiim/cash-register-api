class DiscountsController < ApplicationController
  before_action :set_discount, only: %i[show update destroy]

  # GET /discounts
  def index
    ok json: DiscountService.all
  rescue StandardError => e
    error json: e.expection, status: :internal_server_error
  end

  # GET /discounts/1
  def show
    ok json: @discount
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  # POST /discounts
  def create
    @discount = DiscountService.create!(params: discount_params)

    if @discount.errors.any?
      error json: @discount.errors, status: :unprocessable_entity
    else
      ok json: @discount, status: :created, location: @discount
    end
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  # PATCH/PUT /discounts/1
  def update
    @discount = DiscountService.update!(discount: @discount, params: discount_params)

    if @discount.errors.any?
      error json: @discount.errors, status: :unprocessable_entity
    else
      ok json: @discount
    end
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  # DELETE /discounts/1
  def destroy
    DiscountService.destroy!(discount: @discount)

    ok json: nil, status: :accepted
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_discount
    @discount = DiscountService.get(id: params[:id])
  rescue ActiveRecord::RecordNotFound => e
    error json: e.message, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def discount_params
    parse_params.permit(:id, :product_id, :strategy, :quantity, :discount)
  end
end
