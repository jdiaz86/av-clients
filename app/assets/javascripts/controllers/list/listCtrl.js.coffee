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



	$scope.saveEdit = (client) ->
		client.state = client.state.name  if (client.state?) and (client.state.name?)
		console.log(client)
		
		$scope.validate = clientData.validateInputs(client)

		console.log("UPDATE "  + $scope.validate)
		client.editMode = false;
		#clientData.updateClient(client)

	$scope.deleteClient = (clientId, index) ->
		if confirm('Are you sure you want to delete this client?')
			clientData.deleteClient(clientId)
			$scope.loadTable()
			$scope.clients.splice(index,1)
			
		else
			console.log("not deleting")



	$scope.viewClient = (clientId) ->
		$location.url('client/:' + clientId)

	$scope.navAddClient = ->
		$location.url('/add')

	$scope.about = ->
		$location.url('/about')
	

	$scope.dblClick = (client) ->
		if (!client.editMode) 
			$scope.editClient(client.id)


	$http.jsonp('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.states%20where%20place%3D%22United%20States%22&format=json&diagnostics=true&callback=JSON_CALLBACK').success( (data) ->
		$scope.options = data.query.results.place
	).error( (error) ->
		console.log("error")
	)

	$scope.loadTable = ->
		$resource('./clients.json',{},{}).query().$promise.then( (data) ->
			console.log("DATA")
			console.log(data)
			$scope.tableParams = new ngTableParams(
			  page: 1 # show first page
			  count: 5 # count per page
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

@ListCtrl.$inject = ['$scope', '$http', '$location', '$filter', '$resource', 'clientData', 'ngTableParams']



