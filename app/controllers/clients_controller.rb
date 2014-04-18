class ClientsController < ApplicationController
	respond_to :json

	def index
		#gather all client data
		clients = Client.all

		#Respond to request with client data in json
		respond_with(clients) do |format|
			format.json { render:jso => clients.as_json }
		end
	end
end
