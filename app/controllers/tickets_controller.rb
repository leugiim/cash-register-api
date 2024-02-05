class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show]

  # GET /tickets
  def index
    ok json: TicketService.all
  rescue StandardError => e
    error json: e.expection, status: :internal_server_error
  end

  # GET /tickets/1
  def show
    ok json: @ticket
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  # POST /tickets
  def create
    @ticket = TicketService.create!(params: ticket_params)

    if @ticket.errors.any?
      error json: @ticket.errors, status: :unprocessable_entity
    else
      ok json: @ticket, status: :created, location: @ticket
    end
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  # POST /tickets/preview
  def preview
    @ticket = TicketService.preview(params: ticket_params)

    if @ticket.errors.any?
      error json: @ticket.errors, status: :unprocessable_entity
    else
      ok json: @ticket
    end
  rescue StandardError => e
    error json: e.message, status: :internal_server_error
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = TicketService.get(id: params[:id])
  rescue ActiveRecord::RecordNotFound => e
    error json: e.message, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.permit(:products_ids)
  end
end
