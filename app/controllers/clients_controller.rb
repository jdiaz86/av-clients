class ClientsController < ApplicationController
	respond_to :json

	def update
		Client.update(params[:update_client][:id], { :first_name => params[:update_client][:first_name] ,
												     :last_name => params[:update_client][:last_name] ,
												     :phone_number => params[:update_client][:phone_number] ,
												     :address => params[:update_client][:address] ,
												     :city => params[:update_client][:city] ,
												     :state => params[:update_client][:state] ,
												     :zip_code => params[:update_client][:zip_code] })

	end

	def destroy
		Client.find(params[:id]).destroy

	end

	def create

		new_client = Client.new
		new_client.first_name = params[:new_client][:first_name]
		new_client.last_name = params[:new_client][:last_name]
		new_client.phone_number = params[:new_client][:phone_number]
		new_client.address = params[:new_client][:address]
		new_client.city = params[:new_client][:city]
		new_client.state = params[:new_client][:state]
		new_client.zip_code = params[:new_client][:zip_code]


		if new_client.valid?
			new_client.save!
		else
			render "public/422", status => 422
			return
		end

		respond_with(new_client) do |format|
			format.json { render:json => new_client.as_json}
		end
	end


	def show
		client = Client.find(params[:id])

		respond_with(client) do |format| 
			format.json { render:json => client.as_json}
		end
	end

	def index
		#gather all client data
		clients = Client.all

		#Respond to request with client data in json
		respond_with(clients) do |format|
			format.json { render:json => clients.as_json }
		end
	end
end
