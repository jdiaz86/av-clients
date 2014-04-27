@ListCtrl = ($scope, $http, $location, $filter, $resource, clientData, ngTableParams) ->
	$scope.title = "AV Clients"

	$scope.clients = [{first_name: "Loading data..."}]
	$scope.edit = false;
	$scope.showFilter = false;

	$scope.toogleFilter = -> 
		$scope.showFilter = (if $scope.showFilter is false then true else false)

	$scope.viewClient = (clientId) ->
		$location.url('/client/:' + clientId)

	$scope.editClient = (clientId) ->
		$location.url('/client/' + clientId)

	$scope.navAddClient = ->
		$location.url('/add')

	$scope.about = ->
		$location.url('/about')

	# Method to edit a client
	$scope.saveEdit = (client) ->
		client.state = client.state.name  if (client.state?) and (client.state.name?)
		$scope.validate = clientData.validateInputs(client)
		if ($scope.validate)
			if ( (isValidNumber client.phone_number, "US") && ( ((client.zip_code) && (client.zip_code.length>=5)) || !client.zip_code ) )
				client.editMode = false;
				clientData.updateClient(client)
			else 
				alert("Phone number and/or zip code not valid, try again!")
		else
			alert("You must fill all required fields")

	$scope.deleteClient = (clientId, index) ->
		if confirm('Are you sure you want to delete this client?')
			clientData.deleteClient(clientId)
			$scope.loadTable()
			$scope.clients.splice(index,1)			


	$scope.dblClick = (client) ->
		if (!client.editMode) 
			$scope.editClient(client.id)

	# get US states from yql
	$http.jsonp('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.states%20where%20place%3D%22United%20States%22&format=json&diagnostics=true&callback=JSON_CALLBACK').success( (data) ->
		$scope.options = data.query.results.place
	).error( (error) ->
		console.log("error")
	)

	$scope.loadTable = ->
		$resource('./clients.json',{},{}).query().$promise.then( (data) ->
			$scope.tableParams = new ngTableParams(
			  page: 1 # show first page
			  count: 10 # count per page
			  sorting:
			  	first_name: "asc"
			  filter: 
			  	first_name: ''
			,
			  total: data.length # length of data
			  getData: ($defer, params) ->
			  	orderedData = (if params.sorting() then $filter("orderBy")(data, params.orderBy()) else data)
			  	orderedData = (if params.filter() then $filter('filter')(orderedData,params.filter()) else orderdedData)
			  	$scope.clients = orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
			  	$defer.resolve $scope.clients		    
			)

		)
	
	$scope.loadTable()

	# input watchers for phone and zipcode formats
	$scope.phoneNumberChange = (client) ->
		client.phone_number = formatLocal "US", client.phone_number

	$scope.zipCodeChange = (client) ->
		if ( (client.zip_code) && isNaN(client.zip_code) )
			client.zip_code = client.zip_code.substring(0,client.zip_code.length-1)




@ListCtrl.$inject = ['$scope', '$http', '$location', '$filter', '$resource', 'clientData', 'ngTableParams']