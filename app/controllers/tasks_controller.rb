class TasksController < ApplicationController
    before_filter :signed_in_user
    before_filter :correct_user
    
  	def index
        #-- Load As per Filters
        if ! params[:title].nil?
          @tasks = Task.matching_title(params[:title])
        elsif ! params[:overdue].nil?
          @tasks = Task.non_over_due
        else
          @tasks = Task.all
        end
        
        #-- Apply Sorting If requested
        @tasks = sort_results( @tasks )
  	end

  	def new
  		@task = Task.new
  	end
    
    def edit
    	@task = Task.find(params[:id])
  	end
    
    def update
      @task = Task.find(params[:id])
      
      if @task.update_attributes( params[:task] )
        flash[:success] = "Task Updated."
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
    
    private
    
    def sort_results(tasks)
      unless params[:priority].nil?
        priority_map = {
          'High'   => 1,
          'Medium' => 2,
          'Low'    => 3,
        }
        tasks = tasks.sort! { |a, b|  priority_map[a.priority] <=> priority_map[b.priority] }
      end
      
      unless params[:timing].nil?
        tasks = tasks.sort! { |a, b|  a.timing <=> b.timing }
      end
      
      return tasks
    end
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(tasks_path) unless current_user?(@user)
    end
end
