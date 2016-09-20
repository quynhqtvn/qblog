class UsersController < ApplicationController
	def edit
		@user = current_user
	end

	def index
    	@users = User.where(activated: true).paginate(page: params[:page])
  	end

	def show
		@user = User.find(params[:id])
		@etries = @user.entries.paginate(page:params[:page])
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
		params.require(:user).permit(:email, :user_name, :password, :password_confirmation)
	end
end
