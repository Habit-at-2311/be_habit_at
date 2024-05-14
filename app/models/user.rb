class User < ApplicationRecord
	before_validation :generate_api_key, on: :create

	validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :api_key, presence: true, on: :create

	private

	def	generate_api_key
		self.api_key ||= SecureRandom.hex(16)
	end
end