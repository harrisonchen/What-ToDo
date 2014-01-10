class TasksController < ApplicationController
  	before_action :signed_in_user
    before_action :task_exists , only: [:show, :edit, :destroy]
  before_action :correct_user , only: [:show, :edit, :destroy]

  	def create
  		current_list = List.find(params[:list_id])
  		@task = current_list.tasks.build(task_params)
  		if @task.save
  			cookies.delete(:list_id)
  			flash[:success] = "New task created!"
  			redirect_to current_list
  		else
  			@lists = current_list
			@tasks = @lists.tasks.paginate(page: params[:page])
			@task = @lists.tasks.build if signed_in? # Comment if want form error
			flash.now[:error] = "Please fill in the new task"
  			render 'lists/show'
  		end
  	end

  	def edit
  		@task = Task.find(params[:id])
  	end

  	def update
  		@task = Task.find(params[:id])
  		@task.content = task_params[:content]
  		list = @task.list
  		if @task.save
  			flash[:success] = "Task successfully editted"
  			redirect_to list
  		else
  			flash.now[:error] = "Please fill in task name"
  			@task = Task.find(params[:id])
  			render 'tasks/edit'
  		end
  		
  	end

  	def destroy
  		@task = Task.find(params[:id])
  		list = @task.list
  		flash[:success] = "#{@task.content} task deleted"
  		@task.destroy
  		redirect_to list
  	end

  	private

  		def task_params
  			params.require(:task).permit(:content)
  		end

      def correct_user
        @task = Task.find(params[:id])
        @user = @task.list.user
        if !current_user?(@user)
          flash[:notice] = "Task # does not exist"
          redirect_to root_url
        end
      end

      def task_exists
        Task.find(params[:id])
        rescue
          redirect_to root_url
      end

end