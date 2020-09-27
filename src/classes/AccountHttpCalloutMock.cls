/**
 * Created by lina_ on 27.09.2020.
 */

public with sharing class AccountHttpCalloutMock implements HttpCalloutMock {


    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        switch on request.getMethod() {
            when 'POST' {
                response.setHeader('Content-Type', 'application/json;charset=UTF-8');
                response.setBody('{"name": "TestAccountCallout", "phone": "12345678"}');
            }
            when 'PUT','PATCH' {
                response.setBody(request.getBody());
            }
        }
        return response;
    }
}