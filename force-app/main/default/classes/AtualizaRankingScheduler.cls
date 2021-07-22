public class AtualizaRankingScheduler implements Schedulable {
    public void execute(SchedulableContext sc){
        run();
    }
    
    public void run(){
        Datetime now = System.now();
        List<HabilidadeContato__c> habilidadesContatos = [select id, Contato__c from HabilidadeContato__c 
                                                          where level__c != null 
                                                          and SystemModstamp >= :now.addMinutes(-60) ALL ROWS];
        Set<Id> idsContato = new Set<Id>();
        
        for(HabilidadeContato__c habilidade : habilidadesContatos){
            idsContato.add(habilidade.Contato__c);
        }
        
        //HabilidadeContatoBO.getInstance().atualizaRanking(idsContato);
    }
}