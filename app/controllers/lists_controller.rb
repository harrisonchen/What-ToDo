class ListsController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user, only: :show

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

	def destroy
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
  			@user = User.find(current_user.id)
  			@lists = @user.lists.find(params[:id])
			if @lists.nil?
				redirect_to lists_path
			end
  		end

end