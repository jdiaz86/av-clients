@ListCtrl = ($scope, $http, $location, $filter, $resource, clientData, ngTableParams) ->
	$scope.title = "AV Clients"

	$scope.clients = [{first_name: "Loading data..."}]
	$scope.showFilter = false;

	$scope.toogleFilter = -> 
		$scope.showFilter = (if $scope.showFilter is false then true else false)


	$scope.viewClient = (clientId) ->
		$location.url('client/:' + clientId)

	$scope.navAddClient = ->
		$location.url('/add')

	$resource('./clients.json',{},{}).query().$promise.then( (data) ->
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
		
@ListCtrl.$inject = ['$scope', '$http', '$location', '$filter', '$resource', 'clientData', 'ngTableParams']



