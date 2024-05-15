class ProgressSerializer
  include JSONAPI::Serializer

  attributes :user_id, :habit_id, :status, :start_datetime, :end_datetime

  attribute :tracking_progress do |object|
    object.tracking_progress.map do |progress|
      {
        id: progress.id,
        status: progress.status,
        datetime: progress.datetime
      }
    end
  end
end
