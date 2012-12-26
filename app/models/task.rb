class Task < ActiveRecord::Base
  	attr_accessible :title, :description, :timing, :status, :priority

  	validates :title, presence: true, length: { maximum: 50 }

    validates :timing, presence: true

    validates :priority, presence: true, :inclusion => { :in => %w(High Medium Low),
      :message => "%{value} is not a valid Priority" }

  	before_save :set_status_default


  	private

  	def set_status_default
      if self.status || self.status == 1 
        write_attribute(:status, true)
      else
        write_attribute(:status, false)
      end
      
      true
  	end
end