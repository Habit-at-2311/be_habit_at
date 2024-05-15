class Progress < ApplicationRecord
  belongs_to :habit

  validates :status, presence: true
  validates :datetime, presence: true

  enum status: [:incomplete, :completed, :skipped]
end
