class Api::V0::UsersController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

	def create
		user = User.new(user_params)

		if user.save
			render json: UserSerializer.new(user), status: :ok
		else
			render json: user.errors.full_messages, status: :unprocessable_entity
		end
	end

	def destroy
		user = User.find(user_params[:id])

		user.destroy
		render json: { message: "User #{user.email}, was successfully deleted" }, status: :ok
	end

	def update
		user = User.find(user_params[:id])
		user.update(user_params)

		render json: UserSerializer.new(user), status: :ok
	end

	private

	def handle_record_not_found
		render json: { error: 'User not found' }, status: :not_found
	end

	def user_params
		params.require(:user).permit(:id, :email)
	end
end