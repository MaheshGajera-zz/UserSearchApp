module TasksHelper
  def get_priority_options
    [['High', 'High'], ['Medium', 'Medium'], ['Low', 'Low'] ]
  end
  
  def is_over_due(due_date)
    due_date < DateTime.now
  end

  def get_status_tag(task)
  	return "Over Due" if is_over_due(task.timing)
  	return "Completed" if task.status
  	"Pending"
  end

  def get_description_tag(desc)
  	return "No Description" if desc.empty?
  	desc
  end
end
