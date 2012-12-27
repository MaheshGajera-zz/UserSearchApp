class TasksController < ApplicationController
  	def index
        unless params[:title].nil? || params[:title].blank?
          @tasks = Task.find(:all, :conditions => ['title LIKE ?', "%#{params[:title]}%"])
        else
          @tasks = Task.all
  		end
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
        flash[:success] = "Task created."
        redirect_to action: 'index'
      else
        flash[:success] = "Error while updating task, please retry."
        render 'edit'
      end
  	end
    
  	def create
      @task = Task.new(params[:task])
	    
      if @task.save
	    flash[:success] = "Task created successfully."
	    redirect_to action: "index"
      else
	    render 'new'
	  end
  	end
  	
    def destroy
      Task.find(params[:id]).destroy
      
      flash[:success] = "Task deleted."
      redirect_to action: "index"
  	end
end
