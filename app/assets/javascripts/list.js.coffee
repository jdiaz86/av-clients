# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require_self
#= require_tree ./services/list
#= require_tree ./filters/list
#= require_tree ./controllers/list
#= require_tree ./directives/list

List = angular.module('List',['ngRoute'])

List.config(['$routeProvider',($routeProvider) ->
	$routeProvider.when('/list', { templateUrl: '../assets/list.html',controller: 'ListCtrl' })

	$routeProvider.when('/client/:clientId', { templateUrl: '../assets/client.html', controller: 'ClientCtrl' })

	$routeProvider.otherwise({ redirectTo: '/list' })

])
