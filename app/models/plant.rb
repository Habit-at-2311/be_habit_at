class Plant < ApplicationRecord
	validates :style, :stem, :seed, :petal, :leaf, :grow_rate, :scale, presence: true

	has_many :habit_plants,  dependent: :destroy
	has_many :habits, through: :habit_plants

	def max_scale
		4.0
	end
end
