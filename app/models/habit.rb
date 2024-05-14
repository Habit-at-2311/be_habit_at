class Habit < ApplicationRecord
  validates :frequency, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validates :status, presence: true

  enum status: [:in_progress, :completed]
  enum frequency: [:daily, :weekly, :monthly]

  belongs_to :user
  has_many :progresses, dependent: :destroy

  after_create_commit :create_progresses

  private

  def create_progresses
    (start_datetime.to_date..end_datetime.to_date).each do |datetime|
      progresses.find_or_create_by(datetime: datetime)
    end
  end
end
