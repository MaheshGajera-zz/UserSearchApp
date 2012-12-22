module ApplicationHelper



#-- Generate Full Page Title From Keyword
def full_title(page_title)
    base_title = "Task Manager"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

end
