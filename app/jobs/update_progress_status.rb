class UpdateProgressStatus < ApplicationJob
  queue_as :default

  def perform
    progresses = Progress.incomplete.where("datetime <= ?", Date.current)

    progresses.update_all(status: :skipped)
  end
end
