class HabitPlant < ApplicationRecord
  validates :plant_id, presence: true
  validates :habit_id, presence: true
  validates :grow_rate, presence: true
  validates :scale, presence: true
  validates :status, presence: true

  enum status: [:growing, :wilting, :healthy, :death]

  belongs_to :plant
  belongs_to :habit

  def initial_scale
    plant.scale
  end

  def max_scale
    plant.max_scale
  end
end
