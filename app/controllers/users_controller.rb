class UsersController < ApplicationController
	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
			redirect_to root_path, notice: "Update profile successfully."
		else
			render :edit
		end
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
end
