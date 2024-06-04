class ProgressSerializer
  include JSONAPI::Serializer

  attributes :habit_id, :status, :datetime
  attribute :habit_name do |object|
    object.habit.name
  end
end
