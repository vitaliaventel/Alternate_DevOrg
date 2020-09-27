/**
 * Created by lina_ on 27.09.2020.
 */

@IsTest
public with sharing class TestAccountCallouts {

    private static String id = '1113V000008YiA2QAK';
    private static String name = 'TestAccountCallout';
    private static String phone = '12345678';

    @IsTest
    private static void testGet() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStatusCode(200);
        mock.setStaticResource('AccountCalloutMockResource');
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        Account account = AccountCallouts.getAccountById(id);
        Test.stopTest();
        System.assert(account != null);
        System.assertEquals('TestAccountCallout', account.Name);
    }

    @IsTest
    private static void testPost() {
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        Test.startTest();
        HttpResponse response = AccountCallouts.createAccount(name, phone);
        Test.stopTest();
        System.assertEquals('application/json;charset=UTF-8', response.getHeader('Content-Type'));
        System.assertEquals(200, response.getStatusCode());
        String actualValue = response.getBody();
        String expectedValue = '{"name": "'+name+'", "phone": "'+phone+'"}';
        System.assertEquals(actualValue, expectedValue);
    }

    @IsTest
    private static void testDelete() {
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        Test.startTest();
        HttpResponse response = AccountCallouts.deleteAccount(id);
        Test.stopTest();
        System.assertEquals(200, response.getStatusCode());
    }

    @IsTest
    private static void testPut(){
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        Test.startTest();
        HttpResponse response = AccountCallouts.upsertAccount(id, name, phone);
        Test.stopTest();
        System.assertEquals(200, response.getStatusCode());
        String actualValue = response.getBody();
        String expectedValue = '{"id":"'+id+'","name":"'+name+'","phone":"'+phone+'"}';
        System.assertEquals(expectedValue, actualValue);
    }

    @IsTest
    private static void testPatch(){
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        Test.startTest();
        HttpResponse response = AccountCallouts.updateAccount(id, name, phone);
        Test.stopTest();
        System.assertEquals(200, response.getStatusCode());
        String actualValue = response.getBody();
        String expectedValue = '{"name":"'+name+'","phone":"'+phone+'"}';
        System.assertEquals(expectedValue, actualValue);
    }

}