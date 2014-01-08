class ListsController < ApplicationController
	before_action :signed_in_user
	before_action :list_exists, only: [:show, :edit, :destroy]
	before_action :correct_user, only: [:show, :edit, :destroy]

	def index
		@user = User.find(current_user.id)
		@lists = current_user.lists.paginate(page: params[:page])
		@list = current_user.lists.build if signed_in?
	end

	def show
		@user = User.find(current_user.id)
		@lists = current_user.lists.find(params[:id])
	end

	def new
	end

	def create
		@user = User.find(current_user.id)
		@lists = current_user.lists.paginate(page: params[:page])
		@list = current_user.lists.build(list_params)
		if @list.save
			flash[:success] = "#{@list.category} list created!"
			redirect_to lists_url
		else
			render 'lists/index'
		end
	end

	def edit
	end

	def update
	end

	def destroy
		flash[:success] = "#{@list.category} list successfully deleted"
		@list.destroy
		redirect_to lists_url
	end

	private

		def user_params
  			params.require(:user).permit(:name, :email, :password,
  											:password_confirmation)
  		end

  		def list_params
  			params.require(:list).permit(:category)
  		end

  		def correct_user
  			@user = List.find(params[:id]).user
			if !current_user?(@user)
				flash[:notice] = "List # does not exist"
				redirect_to lists_path
			else
				@list = @user.lists.find(params[:id])
			end
  		end

  		def list_exists
  			List.find(params[:id])
  			rescue
  				redirect_to lists_path
  		end

end