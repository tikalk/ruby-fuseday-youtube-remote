'use strict';

var myApp = angular.module('myApp', []);

myApp.config(function($routeProvider) {
    $routeProvider.when(
    	'/remote',
    	{
    		templateUrl: 'partials/remote.html',
    		controller: 'RemoteCtrl'
    	});
    $routeProvider.when(
    	'/player',
    	{
    		templateUrl: 'partials/player.html',
    		controller: 'PlayerCtrl'
    	});
    $routeProvider.otherwise(
        {
            redirectTo: '/view1'
        });
});
