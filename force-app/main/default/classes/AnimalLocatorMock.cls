@isTest
global class AnimalLocatorMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        
        // Simula éxito si el id = 1
        if(req.getEndpoint().endsWith('/1')) {
            res.setBody('{"animal": {"id": 1, "name": "mocked animal"}}');
            res.setStatusCode(200);
        } else {
            // Simula error para cualquier otro id
            res.setBody('{"error": "Not Found"}');
            res.setStatusCode(500);
        }
        return res;
    }
}
