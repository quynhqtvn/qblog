class UsersController < ApplicationController
	def edit
		@user = current_user
	end

	def index
    	@users = User.paginate(page: params[:page])
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
	def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password,
  									:password_confirmation)
  	end

    #before filters

    #confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    #confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    #confirms an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

	private
	def user_params
		params.require(:user).permit(:email, :user_name, :password, :password_confirmation)
	end
end
