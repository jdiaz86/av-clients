class Client < ActiveRecord::Base
	validates_presence_of :first_name, :last_name, :phone_number
	validates_presence_of :state, :zip_code , if: :address?
	validates_presence_of :state, :zip_code , if: :city?
	validates_presence_of :state , if: :zip_code?
	validates_presence_of :zip_code , if: :state?

end
