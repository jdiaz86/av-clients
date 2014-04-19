@ListCtrl = ($scope, $http, $location, clientData) ->
	$scope.title = "AV Clients"

	$scope.data = clientData.data

	clientData.loadClients()

	$scope.viewClient = (clientId) ->
		$location.url('client/:' + clientId)

	$scope.navAddClient = ->
		$location.url('/add')

@ListCtrl.$inject = ['$scope', '$http', '$location', 'clientData']



