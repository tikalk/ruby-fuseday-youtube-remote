app.factory('weService', function() {
    var service = {};

    service.connect = function() {
        if(service.ws) { return; }

        var ws = new WebSocket("ws://localhost:8000/socket/");

        ws.onopen = function() {
            service.callback("Succeeded to open a connection");
        };

        ws.onerror = function() {
            service.callback("Failed to open a connection");
        }

        ws.onmessage = function(message) {
            service.callback(message.data);
        };

        service.ws = ws;
    }

    service.send = function(message) {
        service.ws.send(message);
    }

    service.subscribe = function(callback) {
        service.callback = callback;
    }

    return service;
});