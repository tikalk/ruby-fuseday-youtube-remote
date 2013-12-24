'use strict';

var myApp = angular.module('myApp', []);

myApp.config(function($routeProvider) {
    $routeProvider
        .when('/player',
    	{
    		templateUrl: 'partials/player.html',
    		controller: 'PlayerCtrl'
    	})
        .otherwise(
        {
            redirectTo: '/player'
        });
});
