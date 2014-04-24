@ClientCtrl = ($scope, $routeParams, $resource, $location, $http, clientData) ->
	$scope.title = "item"

	$scope.data = clientData.data
	clientData.loadClients()

	$scope.navHome = ->
		$location.url('/')


	$scope.clearData = ->
		$scope.client =
		    first_name: ''
		    last_name: ''
		    phone_number: ''
		    address: ''
		    state: ''
		    city: ''
		    zip_code: ''

	$scope.clearData()


	if ( ($scope.edit) || ($scope.view) )
		$scope.client = clientData.clientView
	else
		$scope.clearData()


	$scope.view = false
	$scope.edit = false
	$scope.add = false

	# Remove the ':' from clientId param
	$scope.client.clientId = $routeParams.clientId#substr(1)
	
	# Define what we get in the request (add, edit or view)
	if ($scope.client.clientId)
		unless $scope.client.clientId.indexOf(":") is -1
	  		$scope.client.clientId = $scope.client.clientId.substr(1)
	  		$scope.view = true
		else
			$scope.edit = true
	else 
		$scope.add = true


	# Method from the view, dependeing on add or edit does its job
	$scope.save = (client) ->
		console.log("both add and edit")
		if ($scope.edit)
			$scope.saveEdit(client)
		else
			$scope.saveAdd(client)

	# Method to save a client
	$scope.saveAdd = (client) ->
		console.log("addD")
		clientData.addClient(client)
		console.log($scope.client)

	# Method to edit a client
	$scope.saveEdit = (client) ->
		client.state = client.state.name  if (client.state?) and (client.state.name?)
		$scope.validate = clientData.validateInputs(client)
		client.editMode = false;
		console.log("Edit")

	$http.jsonp('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.states%20where%20place%3D%22United%20States%22&format=json&diagnostics=true&callback=JSON_CALLBACK').success( (data) ->
				$scope.options = data.query.results.place
			).error( (error) ->
				console.log("error")
				console.log(error)
			)


	if ( ($scope.edit) || ($scope.view) )
		$resource('./clients/' + $scope.client.clientId + '.json').get().$promise.then( (data) ->
				console.log("DATA")
				console.log(data)
				$scope.client = data
				console.log($scope.client)
		)

	$scope.$watch "client.phone_number", ->
		$scope.client.phone_number = formatLocal "US", $scope.client.phone_number

	$scope.$watch "client.zip_code", ->
		if ( ($scope.client.zip_code) && isNaN($scope.client.zip_code) )
			$scope.client.zip_code = $scope.client.zip_code.substring(0,$scope.client.zip_code.length-1)



@ClientCtrl.$inject = ['$scope', '$routeParams', '$resource', '$location', '$http', 'clientData']

