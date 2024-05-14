class Api::V0::UsersController < ApplicationController
	def create
		user = User.new(user_params)
		if user.save
			render json: UserSerializer.new(user), status: :ok
		else
			render json: user.errors.full_messages, status: :unprocessable_entity
		end
	end

	def destroy
		user = User.find_by(user_params)
		User.destroy(user)

		
	end

	private

	def user_params
		params.require(:user).permit(:id, :email)
	end
end