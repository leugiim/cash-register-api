class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show]

  # GET /tickets
  def index
    render json: TicketService.all
  end

  # GET /tickets/1
  def show
    render json: @ticket
  end

  # POST /tickets
  def create
    @ticket = TicketService.create!(params: ticket_params)

    if @ticket.errors.any?
      render json: @ticket.errors, status: :unprocessable_entity
    else
      render json: @ticket, status: :created, location: @ticket
    end
  end

  # POST /tickets/preview
  def preview
    @ticket = TicketService.preview(params: ticket_params)

    if @ticket.errors.any?
      render json: @ticket.errors, status: :unprocessable_entity
    else
      render json: @ticket
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = TicketService.get(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.permit(:products_ids)
  end
end
