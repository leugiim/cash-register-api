class ResponseApi
  attr_accessor :status, :http_status, :message, :content

  def ok(data, status)
    @status = "SUCCESS"
    @http_status = parse_status status
    @content = data

    self
  end

  def error(message, status)
    @status = "ERROR"
    @http_status = parse_status status
    @message = message

    self
  end

  def parse_status(status)
    Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
  end
end
