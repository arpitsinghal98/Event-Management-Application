public class locationTriggerHandler {
    
    @future(callout=true)
    public static void verifyAddress( List<Id> recordId ){
        List<Location__c> loc = [Select Id, Name, Verified__c, Street__c, City__c, Postal_Code__c, 
                           State__c From Location__c Where Id=: recordId];
        String baseURL = 'https://us-street.api.smartystreets.com/street-address?auth-id=6c486508-5d17-c474-d3ad-a1df219ed8a2&auth-token=M7oNDyBgX3R9RuyvprJa';

        for(Location__c verifylocation: loc) {
            baseURL+= '&street='+EncodingUtil.urlEncode(verifylocation.Street__c, 'UTF-8')
                    +'&city='+EncodingUtil.urlEncode(verifylocation.City__c, 'UTF-8')
                    +'&state='+EncodingUtil.urlEncode(verifylocation.State__c, 'UTF-8')
                    +'&zipcode='+EncodingUtil.urlEncode(verifylocation.Postal_Code__c, 'UTF-8')
                    +'&match=invalid&candidates=10';
            
            HttpRequest httpReq = new HttpRequest();
            httpReq.setMethod('GET');
            httpReq.setEndpoint(baseURL);
            
            Http http = new Http();
            
            HttpResponse httpRes = new HttpResponse();
            
            try{
                httpRes = http.send(httpReq);
                System.debug(' ResponseBody '+httpRes.getBody());
                if( httpRes.getStatusCode() == 200 && httpRes.getStatus() =='OK'){
                    String responseBody = httpRes.getBody();
                    if(!String.isBlank(responseBody) && responseBody.length() > 2){
                        verifylocation.Verified__c = true;
                    }else{
                        verifylocation.Verified__c = false;
                    }
                    update loc;
                }else{
                    Error_Log.Error_Log_1( httpRes.getBody() , 'LocationTriggerHandler');
                }
            }catch(System.CalloutException ex ){
                System.debug(' Exception Executed '+ex.getStackTraceString());
                Error_Log.Error_Log(ex, 'LocationTriggerHandler');
            }
        }
    }
}