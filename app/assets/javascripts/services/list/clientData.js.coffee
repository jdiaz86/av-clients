angular.module('List').factory('clientData', ['$http', '$location', '$sanitize', ($http, $location, $sanitize) ->

	clientData = 
		data:
			clients: [{first_name: 'Loading...'}]
		isLoaded: false
		clientArray: []
		clientView: []

	#Method to delete a client by id
	clientData.deleteClient = (clientId) ->
		data =
			delete_client:
				id: clientId
		$http.delete('./clients/'+data.delete_client.id,data)

	#Method to update an existing client
	clientData.updateClient = (client) ->
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
		$http.put('./clients/'+data.update_client.id,data).success( (data) ->
			alert("Client updated!")
		).error ( ->
			console.log("fail")
			alert("error on update client")
		)

	#Method to create a new client
	clientData.addClient = (newClient) ->
		data =
			new_client:
				first_name: $sanitize(newClient.first_name)
				last_name: $sanitize(newClient.last_name)
				phone_number: newClient.phone_number
				address: $sanitize(newClient.address)
				city: $sanitize(newClient.city)
				state: newClient.state.name
				zip_code: newClient.zip_code

		$http.post('./clients.json',data).success( (data) ->
			clientData.data.clients.push(data)
			alert("Client added!")
			$location.url('/')
			return true
		).error( ->
			alert("Error on create new client")
			return false
		)

	
	#Method to get one client to show
	clientData.getClient = (clientId) ->
		$http.get('./clients/' + clientId + '.json').success( (data) ->
			clientData.clientView = data
		).error( ->
			alert("error getting one client")
		)
 
	#Method to load all clients from api
	clientData.loadClients = ->
		if !clientData.isLoaded
			$http.get('./clients.json').success( (data) ->
				clientData.data.clients = data
				clientData.isLoaded = true
			).error( ->
				alert("Cannot get all clients")
			)


	clientData.validateInputs = (client) ->
		# validates address {zip_code and state}
		if (client.address isnt "") and ((client.zip_code is "") or (not (client.state?)))
			return false
		# validates city {zip_code and state}
		if (client.city isnt "") and ((client.zip_code is "") or (not (client.state?)))
			return false
		# validates zip_code if state
		if (client.sate?) and (client.zip_code is "")
			return false
		# validates state if zip_code
		if (client.zip_code isnt "") and (not (client.state?))
			return false

		return true

	return clientData

])