class Plant < ApplicationRecord
	validates :style, :stem, :seed, :petal, :leaf, :scale, presence: true

	has_many :habits, dependent: :destroy
end