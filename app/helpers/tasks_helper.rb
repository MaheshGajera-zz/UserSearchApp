module TasksHelper
  def get_priority_options
    [['High', 'High'], ['Medium', 'Medium'], ['Low', 'Low'] ]
  end
  
  def is_over_due(due_date)
    due_date < DateTime.now
  end
end
