class ErrorSerializer
  def initialize(error)
    @error = error
    @status_code = error.status_code
  end

  def serialize_json
    {
      errors: [{
        detail: @error.message,
        status_code: @status_code
      }]
    }
  end
end