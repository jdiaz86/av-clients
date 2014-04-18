@ListCtrl = ($scope, $http, clientData) ->
	$scope.title = "AV Clients"

	$scope.data = clientData.data

	clientData.loadClients()



