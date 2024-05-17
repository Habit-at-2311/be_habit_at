class HabitSerializer
  include JSONAPI::Serializer
  attributes :user_id, :name, :description, :frequency, :custom_frequency, :start_datetime, :end_datetime, :status
end
