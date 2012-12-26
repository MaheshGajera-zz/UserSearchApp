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
        redirect_to action: 'index'
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
	    redirect_to action: 'new'
	  end
  	end
  	
    def destroy
      Task.find(params[:id]).destroy
      
      flash[:success] = "Task deleted."
      redirect_to action: "index"
  	end
end
