@ClientCtrl = ($scope, $routeParams, $resource, clientData) ->
	$scope.title = "item"

	$scope.clientView = clientData.clientView
	

	# Remove the ':' from clientId param
	$scope.clientView.clientId = $routeParams.clientId.substr(1)
	
	clientData.getClient($scope.clientView.clientId)

	console.log("hola")
	console.log(clientData.clientView)


	$resource('./clients/' + $scope.clientView.clientId + '.json').get().$promise.then( (data) ->
			console.log("DATA")
			console.log(data)
			$scope.clientView = data
			console.log($scope.clientView)
	)

@ClientCtrl.$inject = ['$scope', '$routeParams', '$resource', 'clientData']

