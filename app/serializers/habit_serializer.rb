class HabitSerializer
  include JSONAPI::Serializer

  attributes :frequency, :start_datetime, :end_datetime, :status
end
