@ClientCtrl = ($scope, $routeParams, $resource, $location, $http, clientData) ->
	$scope.title = "item"

	$scope.navHome = ->
		$location.url('/')

	$scope.client = clientData.clientView
	$scope.view = false
	$scope.edit = false

	# Remove the ':' from clientId param
	$scope.client.clientId = $routeParams.clientId#substr(1)
	
	unless $scope.client.clientId.indexOf(":") is -1
  		console.log("view")
  		$scope.client.clientId = $scope.client.clientId.substr(1)
  		$scope.view = true
	else
		$scope.edit = true
		console.log ("edit")

	$scope.saveEdit = (client) ->
		client.state = client.state.name  if (client.state?) and (client.state.name?)
		console.log(client)
		
		$scope.validate = clientData.validateInputs(client)

		console.log("UPDATE "  + $scope.validate)
		client.editMode = false;
		#clientData.updateClient(client)

	$http.jsonp('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.states%20where%20place%3D%22United%20States%22&format=json&diagnostics=true&callback=JSON_CALLBACK').success( (data) ->
				$scope.options = data.query.results.place
			).error( (error) ->
				console.log("error")
				console.log(error)
			)


	console.log("edit: " + $scope.edit)
	console.log("view: " + $scope.view)

	clientData.getClient($scope.client.clientId)

	console.log("hola")
	console.log(clientData.client)


	$resource('./clients/' + $scope.client.clientId + '.json').get().$promise.then( (data) ->
			console.log("DATA")
			console.log(data)
			$scope.client = data
			console.log($scope.client)
	)

@ClientCtrl.$inject = ['$scope', '$routeParams', '$resource', '$location', '$http', 'clientData']

