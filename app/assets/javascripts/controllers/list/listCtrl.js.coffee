@ListCtrl = ($scope, $http) ->
	$scope.title = "AV Clients"
	
	$scope.data = 
		clients: []

	loadClients = ->
		$http.get('./clients.json').success( (data) ->
			$scope.data.clients = data
			console.log(data) 
		).error( ->
			console.error("failed")
		)

	loadClients()
