/**
 * Created by lina_ on 16.09.2020.
 */

public with sharing class AccountCallouts {
    public static String ENDPOINT_URL = 'https://eu27.salesforce.com/services/apexrest/Account/';

    public static Account getAccountById(Id accountId) {
        Account acc;
        Http http = new Http();
        HttpRequest request = prepareRequestId('GET', accountId);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            acc = (Account) JSON.deserialize(response.getBody(), Account.class);
        }
        System.debug(acc);
        return acc;
    }

    public static HttpResponse createAccount(String name, String phone) {
        Http http = new Http();
        String requestBody = '{"name":"'+name+'", "phone":"'+phone+'"}';
        HttpRequest request = prepareRequestBody('POST', requestBody);
        HttpResponse response = http.send(request);
        debugResponseStatus(response);
        return response;
    }

    public static HttpResponse deleteAccount(Id accountId) {
        Http http = new Http();
        HttpRequest request = prepareRequestId('DELETE', accountId);
        HttpResponse response = http.send(request);
        debugResponseStatus(response);
        return response;
    }

    public static HttpResponse upsertAccount(String id, String name, String phone) {
        Http http = new Http();
        String requestBody = '{"id":"'+id+'","name":"'+name+
                '","phone":"'+phone+'"}';
        HttpRequest request = prepareRequestBody('PUT', requestBody);
        HttpResponse response = http.send(request);
        debugResponseStatus(response);
        return response;
    }

    public static HttpResponse updateAccount(String id, String name, String phone) {
        String requestBody = '{"name":"'+name+'","phone":"'+phone+'"}';
        Http http = new Http();
        HttpRequest request = prepareRequestIdBody('PATCH', id, requestBody);
        HttpResponse response = http.send(request);
        System.debug(response.getStatusCode());
        debugResponseStatus(response);
        return response;
    }

    public static HttpRequest prepareRequest(String method) {
        String accessToken = OAuth2Manager.authorize();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer '+accessToken);
        request.setMethod(method);
        request.setEndpoint(ENDPOINT_URL);
        return request;
    }

    public static HttpRequest prepareRequestId(String method, String Id) {
        HttpRequest request = prepareRequest(method);
        request.setEndpoint(request.getEndpoint()+Id);
        return request;
    }

    public static HttpRequest prepareRequestBody(String method, String body) {
        HttpRequest request = prepareRequest(method);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(body);
        return request;
    }

    public static HttpRequest prepareRequestIdBody(String method, String Id, String body) {
        HttpRequest request = prepareRequestId(method, Id);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(body);
        return request;
    }

    private static void debugResponseStatus(HttpResponse response) {
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: '+
                    response.getStatusCode()+' '+response.getStatus());
        } else {
            System.debug(response.getBody());
        }
    }
}