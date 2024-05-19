class HabitSerializer
  include JSONAPI::Serializer

  attributes :user_id, :plant_id, :name, :description, :frequency, :start_datetime, :end_datetime, :status
end
