class ApplicationController < ActionController::API
  def ok(json:, status: :ok, location: nil)
    response = ResponseApi.new.ok(json, status)
    render json: response, status:, location:
  end

  def error(json:, status:)
    response = ResponseApi.new.error(json, status)
    render json: response, status:
  end

  def parse_params
    params.deep_transform_keys(&:underscore)
  end
end
