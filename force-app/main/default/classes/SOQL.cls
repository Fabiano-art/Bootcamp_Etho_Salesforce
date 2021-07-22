public class SOQL {
	
    public static List<Contact> getAllContacts(){
        List<Contact> contatos = [select id, name from Contact];
        return contatos;
    }
    
    public static Contact getContactById(String id){
        return [select id, name from Contact where id = :id];
    }
    
    public static Map<String, Decimal> getAverage(){
        AggregateResult[] results = [select Contato__r.NomeGuerra__c nomeGuerra, count(id) idcont from HabilidadeContato__c group by Contato__r.NomeGuerra__c];
        
        Map<String, Decimal> mapa = new Map<String, Decimal>();
        
        for(AggregateResult result : results){
            String nomeGuerra = (String) result.get('nomeGuerra');
            Decimal media = (Decimal) result.get('idcont');
            
            mapa.put(nomeGuerra, media);
        }
        return mapa;
    }
}