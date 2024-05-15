class HabitSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :frequency, :start_datetime, :end_datetime, :status
end
