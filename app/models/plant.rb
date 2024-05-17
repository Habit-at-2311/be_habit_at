class Plant < ApplicationRecord
	has_many :habits, dependent: :destroy
end