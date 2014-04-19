@AddClientCtrl = ($scope, $location, $http, clientData) ->

	$scope.navHome = ->
     $location.url('/')

	$scope.data = clientData.data
	clientData.loadClients()

	$scope.clearData = ->
		$scope.formData =
		    firstName: ''
		    lastName: ''
		    phoneNumber: ''
		    address: ''
		    state: ''
		    city: ''
		    zipCode: ''

	$scope.clearData()

	$http.get('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.states%20where%20place%3D%22United%20States%22&format=json&diagnostics=true&callback=').success( (data) ->
				console.log(data.query.results.place)
				$scope.options = data.query.results.place


			).error( ->
				console.log("error")
			)

	$scope.addClient = ->
     	console.log($scope.formData)

@AddClientCtrl.$inject = ['$scope', '$location', '$http', 'clientData']