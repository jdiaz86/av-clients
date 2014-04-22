angular.module('List').factory('clientData', ['$http', '$location', ($http,$location) ->

	clientData = 
		data:
			clients: [{first_name: 'Loading...'}]
		isLoaded: false
		clientArray: []

	#Method to delete a client by id
	clientData.deleteClient = (clientId) ->
		data =
			delete_client:
				id: clientId
		$http.delete('./clients/'+data.delete_client.id,data)

	#Method to update an existing client
	clientData.updateClient = (client) ->
		console.log("beff")
		console.log(client)
		data =
			update_client:
				id: client.id
				first_name: client.first_name
				last_name: client.last_name
				phone_number: client.phone_number
				address: client.address
				city: client.city
				state: client.state
				zip_code: client.zip_code
		console.log("before going to server")
		console.log(data)
		$http.put('./clients/'+data.update_client.id,data)

	#Method to create a new client
	clientData.addClient = (newClient) ->
		data =
			new_client:
				first_name: newClient.firstName
				last_name: newClient.lastName
				phone_number: newClient.phoneNumber
				address: newClient.address
				city: newClient.city
				state: newClient.state.name
				zip_code: newClient.zipCode

		$http.post('./clients.json',data).success( (data) ->
			clientData.data.clients.push(data)
			#add label on client list
			alert("Added new client")
			$location.url('/')
			return true
		).error( ->
			alert("Error on create new client")
			return false
		)

	

	#Method to load all clients from api
	clientData.loadClients = ->
		if !clientData.isLoaded
			$http.get('./clients.json').success( (data) ->
				clientData.data.clients = data
				clientData.isLoaded = true
				console.log("success")
				console.log(data) 
			).error( ->
				console.error("failed")
			)


	return clientData

])