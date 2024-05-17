class ErrorSerializer
  attr_reader :serialize_error

  def initialize(error)
    @error = error
    @status_code = error.status_code
  end

  def serialize_error
    {
      errors: [{
        detail: @error.message.scan(/^[^\[]+/).join.strip,
        status_code: @status_code
      }]
    }
  end
end