class HabitPlantSerializer
  include JSONAPI::Serializer

  attributes :plant_id, :habit_id, :grow_rate, :scale, :status
end
