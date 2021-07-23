public class HabilidadeContatoBO {
	private static final HabilidadeContatoBO instance = new HabilidadeContatoBO();
    
    private HabilidadeContatoBO(){
        
    }
    
    public static HabilidadeContatoBO getInstance(){
        return instance;
    }
    
    public void atualizaRanking(Set<Id> idsContato){
        Map<Id,Contact> mapContatosRevisarRanking = new Map<Id,Contact>([SELECT Id, 
                                                                             		(SELECT Id, Name, Level__c FROM Habilidades__r 
                                                                                     WHERE Level__c != null ORDER BY Level__c DESC, name) 
                                                                             FROM Contact 
                                                                             WHERE Id in : idsContato]);
        
        List<HabilidadeContato__c> habilidadesParaAtualizarRanking = new List<HabilidadeContato__c>();
            for(Contact contato : mapContatosRevisarRanking.values())
            {
                if(!contato.Habilidades__r.isEmpty())
                {
                    Integer ranking = 1;
                    for(HabilidadeContato__c habilidadeContato : contato.Habilidades__r)
                    {
                        habilidadeContato.Ranking__c = ranking++;
                        habilidadesParaAtualizarRanking.add(habilidadeContato);
                    }
                }
            }
            
            TriggerHandler.bypass('HabilidadeContatoTriggerHandler');
            update habilidadesParaAtualizarRanking;
            TriggerHandler.clearBypass('HabilidadeContatoTriggerHandler');
    }
}