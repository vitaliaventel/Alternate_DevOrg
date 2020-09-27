/**
 * Created by lina_ on 17.09.2020.
 */

public class OAuth2Manager {
    public String access_token {get;set;}

    public static String authorize(){
        String clientId = '3MVG9bhkrN.tsmW.crj0wmd.W3cZRkBIhJ3DeD2u63jVthctiG5RMsaTodW25.ya8QppXWyzEUEsWnFRqbskh';
        String clientSecret = '**************************************';
        String username = 'lina_chentsova@epam.com';
        String password = '*************************';
        String requestBody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='
                +username+'&password='+password;
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setBody(requestBody);
        request.setMethod('POST');
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HttpResponse response = h.send(request);
        OAuth2Manager objAuthenticationInfo = (OAuth2Manager) JSON.deserialize(response.getBody(), OAuth2Manager.class);
        return objAuthenticationInfo.access_token;
    }
}