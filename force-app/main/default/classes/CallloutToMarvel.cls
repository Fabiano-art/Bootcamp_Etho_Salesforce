public class CallloutToMarvel {
	public static final String apiKey = 'b948b7032ec87bb7e9190b35b14ee517';
    public static final String hash = '06e9cd3072d542c27ca88fcb712cb702';
    
    @future(callout=true)
    public static void getcharacters(){
        final String endPoint = 'http://gateway.marvel.com/v1/public/events/310/characters?apikey='+apiKey+'&hash='+hash+'&ts=1';
        
        try {
            Http http = new Http();
            httpRequest request = new httpRequest();
            
            request.setEndpoint(endPoint);
            request.setMethod('GET');
            
            HttpResponse response = http.send(request);
            System.debug('response :' + response);
            if(response.getStatusCode() == 200){
                // string = chave / Object = valor
                Map<String, Object> dataResults = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                Map<String, Object> data = (Map<String, Object>) dataResults.get('data');
                List<Object> results = (List<Object>) data.get('results');
                
                if(!results.isEmpty()) upsertCharacters(results);
            }
            else {
                system.debug('Status error: '+response.getStatusCode());
            }
        }
        catch(Exception e){
            System.debug('Error: '+e.getMessage());
        }
    }
    
    private static void upsertCharacters(List<Object> listCharacters){
        List<Lead> leads = new List<Lead>();
        for(Object character : listCharacters){
           	Map<String, Object> mapCharac = (Map<String, Object>) character;
            Lead lead = new Lead();
            lead.Company = 'Marvel API';
            lead.NomeGuerra__c = String.valueOf(mapCharac.get('name'));
            lead.Description = String.valueOf(mapCharac.get('description'));
            lead.LastName = String.valueOf(mapCharac.get('name'));
            lead.LeadSource = 'Importado pela Marvel API';
            lead.MobilePhone = '1112345678';
            lead.Planeta__c = 'terra';
            leads.add(lead);
            System.debug('name do heroi: '+mapCharac.get('name'));
        }
        if (!leads.isEmpty()) upsert leads NomeGuerra__c;
    }
}