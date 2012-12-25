class Task < ActiveRecord::Base
  	attr_accessible :title, :description, :timing, :status

  	validates :title, presence: true, length: { maximum: 50 }

  	before_save :set_status_default


  	private

  	def set_status_default
      write_attribute(:status, false)
      true
  	end
end