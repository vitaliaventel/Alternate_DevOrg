/**
 * Created by lina_ on 17.09.2020.
 */

public class OAuth2Manager {
    public String accessToken {get;set;}

    public static String authorize(){
        String clientId = '3MVG9bhkrN.tsmW.crj0wmd.W3cZRkBIhJ3DeD2u63jVthctiG5RMsaTodW25.ya8QppXWyzEUEsWnFRqbskh';
        String clientSecret = '7F78303CBC7E3E7D9185C3D2B5253631FD2BA59176CEFF2DCD3118982A6526D2';
        String username = 'lina_chentsova@epam.com';
        String password = 'Uli4ka5544v0H8wKT3HDKTRgJk15Q4nU4GJ';
        String requestBody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='
                +username+'&password='+password;
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setBody(requestBody);
        request.setMethod('POST');
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HttpResponse response = h.send(request);
        OAuth2Manager objAuthenticationInfo = (OAuth2Manager) JSON.deserialize(response.getBody(), OAuth2Manager.class);
        return objAuthenticationInfo.accessToken;
    }
}