@IsTest
public class HabilidadeContatoTest {
	@testSetup
    public static void setup(){
        Contact cap = new Contact(firstName = 'Steven', lastName= 'rogers', NomeGuerra__c='Capitão america',Status_candidato__c = 'Aprovado direto');
        Contact viuva = new Contact(firstName = 'Natasha', lastName= 'romanova', NomeGuerra__c='viuva negra',Status_candidato__c = 'aprovado direto');
        List<Contact> herois = new List<Contact> {cap, viuva};
        insert herois;
        
        Habilidade__c supForca = new Habilidade__c(name = 'Super forte');
        Habilidade__c art = new Habilidade__c(name = 'Artes marciais');
        
        List<Habilidade__c> habilidades = new List<Habilidade__c>();
        habilidades.add(supForca);
        habilidades.add(art);
        insert habilidades;
        
        HabilidadeContato__c  habilidadeContato_1 = new HabilidadeContato__c();
        habilidadeContato_1.Contato__c = cap.Id;
        habilidadeContato_1.Habilidade__c = supForca.Id;
        habilidadeContato_1.Level__c = 90;
        
        HabilidadeContato__c  habilidadeContato_2 = new HabilidadeContato__c();
        habilidadeContato_2.Contato__c = viuva.Id;
        habilidadeContato_2.Habilidade__c = art.Id;
        habilidadeContato_2.Level__c = 40;
        
        List<HabilidadeContato__c> habiliContatos = 
        new List<HabilidadeContato__c> {habilidadeContato_1, habilidadeContato_2};
        
        insert habiliContatos;
    }
    
    @IsTest
    public static void validaNovoRankingBaforeUpdate(){
        List<HabilidadeContato__c> habilidadesValida = [select id, Habilidade__r.name , ranking__c
                                                  from HabilidadeContato__c 
                                                  where contato__r.NomeGuerra__c = 'Capitão america'
                                                 and ranking__c != null];
        
        //System.assert(habilidadesValida.size() == 1);
        System.assertEquals(1, habilidadesValida.size());
        
        for(HabilidadeContato__c habContato : habilidadesValida){
            
            switch on habContato.Habilidade__r.name{
                when 'Super forte'{
                    System.assertEquals(1, habContato.Ranking__c);
                }
            }
        }
    }
    
    @isTest
    public static void validaQuandoRankingNulo(){
        HabilidadeContato__c habilidadeContato = [select id, ranking__c from habilidadeContato__c 
                                                  where Contato__r.NomeGuerra__c = 'viuva negra'
                                                 and habilidade__r.name = 'Artes marciais'];
        
        System.assertEquals(null, habilidadeContato.Ranking__c);
    }
    
    @isTest
    public static void validaQuandoRankingAfterUpdate(){
        List<HabilidadeContato__c> habilidadesContato = [select id, Habilidade__r.name , ranking__c
                                                  		from HabilidadeContato__c 
                                                        order by Contato__r.nomeGuerra__c];
    }
}