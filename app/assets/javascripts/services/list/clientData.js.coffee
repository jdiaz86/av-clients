angular.module('List').factory('clientData', ['$http', '$location', ($http,$location) ->

	clientData = 
		data:
			clients: [{first_name: 'Loading...'}]
		isLoaded: false
		clientArray: []

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