class TasksController < ApplicationController
  	def index
  		@tasks = Task.all
  	end

  	def new
  		@task = Task.new
  	end

  	def show
    	@task = Task.find(params[:id])
  	end
    
    def edit
    	@task = Task.find(params[:id])
  	end
    
    def update
      @task = Task.find(params[:id])
      
      if @task.update_attributes( params[:task] )
        redirect_to @task
      else
        render 'edit'
      end
  	end
    
  	def create
      @task = Task.new(params[:task])
	    
      if @task.save
	    flash[:success] = "Task created."
	    redirect_to @task
	  else
	    render 'new'
	  end
  	end
  	
    def destroy
      @task = Task.find(params[:id])
      
      @task.destroy
      
      redirect_to 'index'
  	end
end
