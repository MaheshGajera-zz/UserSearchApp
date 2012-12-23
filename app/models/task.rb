class Task < ActiveRecord::Base
  	attr_accessible :title, :description, :timing, :status

  	validates :title, presence: true, length: { maximum: 50 }

  	before_save :set_status_default
  	

	define_method "timing_before_type_cast" do
        self.send("timing").to_s
    end

  	private

  	def set_status_default
    	self.status ||= false
  	end
end