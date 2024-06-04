class Progress < ApplicationRecord
  belongs_to :habit

  validates :status, presence: true
  validates :datetime, presence: true

  enum status: [:incomplete, :completed, :skipped]

  after_update_commit :update_plant

  private

  def update_plant
    plant_growing =
    case status
    when 'completed'
      false
    when 'skipped'
      true
    end
  grow_service = GrowPlantService.new(habit.habit_plant, plant_growing)
  grow_service.update
  end
end
