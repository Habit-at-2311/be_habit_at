class Api::V0::UsersController < ApplicationController
	def show
		user = User.find(params[:id])
		
		if user
			render json: UserSerializer.new(user)
		end
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: UserSerializer.new(user), status: :ok
		else
			raise ActiveRecord::RecordInvalid
		end
	end

	def destroy
		require 'pry'; binding.pry
		user = User.find(params[:id])
		user.destroy

		render json: { message: "User #{user.email}, was successfully deleted" }, status: :ok
	end

	def update
		user = User.find(user_params[:id])
		user.update(user_params)

		render json: UserSerializer.new(user), status: :ok
	end

	private

	def user_params
		params.require(:user).permit(:id, :name, :email)
	end
end