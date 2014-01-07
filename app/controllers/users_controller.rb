class UsersController < ApplicationController
    before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
    before_action :correct_user, only: [:edit, :update]
    before_action :admin_user, only: [:index, :destroy]
  
  	def new
  		@user = User.new
  	end

    def index
      @users = User.paginate(page: params[:page])
    end

  	def show
  		@user = User.find(params[:id])
  	end

  	def create
  		@user = User.new(user_params)
  		if @user.save
  			sign_in @user
  			flash[:success] = "Welcome to What-ToDo!"
  			redirect_to @user
  		else
  			render 'new'
  		end
  	end

  	def edit
  		#@user = User.find(params[:id])
  	end

  	def update
  		#@user = User.find(params[:id])
  		if @user.update_attributes(user_params)
  			flash[:success] = "Profile updated"
  			redirect_to @user
  		else
  			render 'edit'
  		end
  	end

    def destroy
      user = User.find(params[:id])
      if current_user?(user) && current_user.admin?
        flash[:error] = "Admins cannot be deleted"
        redirect_to root_url
      else
        deleted_user = User.find(params[:id]).destroy
        flash[:success] = "User: #{deleted_user.email} deleted"
        redirect_to users_url
      end
    end

  	private

  		def user_params
  			params.require(:user).permit(:name, :email, :password,
  											:password_confirmation)
  		end

      # Before filters

      def signed_in_user
        if !signed_in?
          store_location
          redirect_to signin_url, notice: "Please sign in."
        end
      end

      def correct_user
        @user = User.find(params[:id])
        if !current_user?(@user)
          redirect_to(root_url)
        end
      end

      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end

end
