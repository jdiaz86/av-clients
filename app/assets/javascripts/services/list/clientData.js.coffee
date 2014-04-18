angular.module('List').factory('clientData', ['$http', ($http) ->

	clientData = 
		data:
			clients: [{first_name: 'hola'}]
		isLoaded: false

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