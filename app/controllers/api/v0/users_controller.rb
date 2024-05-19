class Api::V0::UsersController < ApplicationController
	def show
		user = User.find(params[:id])

		render json: UserSerializer.new(user)
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: UserSerializer.new(user), status: :ok
		else
      render json: user.errors.as_json(full_messages: true), status: 400
		end
	end

	def destroy
		user = User.find(params[:id])
		if user.destroy
			render json: { message: "User #{user.email}, was successfully deleted" }, status: :ok
		else
      render json: user.errors.as_json(full_messages: true), status: 422
		end
	end

	def update
		user = User.find(params[:id])
		if user.update(user_params)
			render json: UserSerializer.new(user), status: :ok
		else
			render json: user.errors.as_json(full_messages: true), status: 422
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email)
	end
end
