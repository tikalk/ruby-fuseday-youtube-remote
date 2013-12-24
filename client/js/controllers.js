'use strict';

myApp.controller("PlayerCtrl" ,function ($scope, wsService) {
    $scope.video = '';

    wsService.subscribe(function(message) {
        $scope.messages = message.youtube_video_id;
        $scope.$apply();
    });

    wsService.connect();
});