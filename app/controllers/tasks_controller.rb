class TasksController < ApplicationController
  	def index
        #-- Load As per Filters
        if ! params[:title].nil?
          @tasks = Task.find(:all, :conditions => ['title LIKE ?', "%#{params[:title]}%"])
        elsif ! params[:overdue].nil?
          @tasks = Task.find(:all, :conditions => ['timing  > ?', DateTime.now ] )
        else
          @tasks = Task.all
        end
        
        #-- Apply Sorting If requested
        if has_sorting?
          @tasks = sort_results( @tasks )
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
    
    private
    
    def has_sorting?
      unless params[:priority].nil?
        return true
      end
      unless params[:timing].nil?
        return true
      end
      return false
    end
    
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
end
