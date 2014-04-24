###
@AddClientCtrl = ($scope, $location, $http, $sanitize, $sce, clientData) ->

	$scope.navHome = ->
     $location.url('/')

	$scope.data = clientData.data
	clientData.loadClients()

	$scope.$watch "formData.phoneNumber", ->
		$scope.formData.phoneNumber = formatLocal "US", $scope.formData.phoneNumber

	$scope.$watch "formData.zipCode", ->
		if isNaN($scope.formData.zipCode)
			$scope.formData.zipCode = $scope.formData.zipCode.substring(0,$scope.formData.zipCode.length-1)

	$scope.$watch "formData.firstName", ->
		#console.log( $sce.getTrustedHtml($sce.trustAsHtml($scope.formData.firstName)))
		#$scope.formData.firstName = $sce.trustAsHtml($scope.formData.firstName)

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

	$http.jsonp('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.states%20where%20place%3D%22United%20States%22&format=json&diagnostics=true&callback=JSON_CALLBACK').success( (data) ->
				$scope.options = data.query.results.place
			).error( (error) ->
				console.log("error")
				console.log(error)
			)

	$scope.addClient = ->
		clientData.addClient($scope.formData)
		console.log($scope.formData)
			 



@AddClientCtrl.$inject = ['$scope', '$location', '$http', '$sanitize', '$sce', 'clientData']
###