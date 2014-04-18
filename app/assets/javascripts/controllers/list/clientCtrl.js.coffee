@ClientCtrl = ($scope, $routeParams, clientData) ->
	$scope.title = "item"

	$scope.data = clientData.data

	clientData.loadClients()
	

	# Remove the ':' from clientId param
	$scope.data.clientId = $routeParams.clientId.substr(1)

@ClientCtrl.$inject = ['$scope', '$routeParams', 'clientData']

