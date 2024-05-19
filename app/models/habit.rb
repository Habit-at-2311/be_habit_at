class Habit < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :frequency, presence: true
  validates :custom_frequency, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validates :status, presence: true
  validates :plant_id, presence: true

  enum status: [:in_progress, :completed]
  enum frequency: [:daily, :weekly, :monthly]

  belongs_to :user
  belongs_to :plant

  has_many :progresses, dependent: :destroy

  after_create_commit :create_progresses

  private

  def create_progresses
    if daily?
      create_daily_progresses
    elsif weekly?
      create_weekly_progress
    else
      create_monthly_progress
    end
  end

  def create_daily_progresses
    (start_datetime.to_date..end_datetime.to_date).each do |datetime|
      progresses.find_or_create_by(datetime: datetime)
    end
  end

  def create_weekly_progress
    (start_datetime.to_date..end_datetime.to_date).each do |datetime|
      day = datetime.strftime("%A").downcase

      if custom_frequency.with_indifferent_access["#{day}"]
        progresses.find_or_create_by(datetime: datetime)
      end
    end
  end

  def create_monthly_progress
    (start_datetime.to_date..end_datetime.to_date).each do |datetime|
      if first_week?(datetime)
        day = datetime.strftime("%A")
        if custom_frequency["#{day}"]
          progresses.find_or_create_by(datetime: datetime)
        end
      end
    end
  end

  def first_week?(date)``
    date.day <= 7
  end
end
