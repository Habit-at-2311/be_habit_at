class ProgressSerializer
  include JSONAPI::Serializer

  attributes :habit_id, :status, :datetime
end
