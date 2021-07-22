@isTest
public class ContactCreateTaskTest {
	
    @testSetup
    public static void setup(){
        Contact capitaoAmerica = new Contact(FirstName='Steve', LastName='Rogers', 
                                             NomeGuerra__c='Capitão América', 
                                             Status_candidato__c='Aprovado direto',
                                            MobilePhone = '11912345678',
                                            Nivel_de_poder__c = '10');
        
        Contact peterParker = new Contact(FirstName='Peter', LastName='parker', 
                                             NomeGuerra__c='Homem Aranha', 
                                             Status_candidato__c='Em análise',
                                         	MobilePhone = '11912345678',
                                         Nivel_de_poder__c = '7');
        
        List<Contact> herois = new List<Contact>{capitaoAmerica, peterParker};
        insert herois;
        
        Habilidade__c forca = new Habilidade__c(name='Super forca');
        Habilidade__c inteligencia = new Habilidade__c(name='inteligencia');
        
        HabilidadeContato__c habcon_1 = new HabilidadeContato__c();
        habcon_1.Contato__c = capitaoAmerica.Id;
		habcon_1.Habilidade__c = forca.Id;
        
        HabilidadeContato__c habcon_3 = new HabilidadeContato__c();
        habcon_3.Contato__c = capitaoAmerica.Id;
		habcon_3.Habilidade__c = inteligencia.Id;
        
        HabilidadeContato__c habcon_2 = new HabilidadeContato__c();
        habcon_2.Contato__c = peterParker.Id;
		habcon_2.Habilidade__c = forca.Id;
        
        List <HabilidadeContato__c> habilidades = new List<HabilidadeContato__c> {habcon_1, habcon_2, habcon_3};
        insert habilidades;
	}
    
    @isTest
    public static void validateTaskCreation(){
        
        List<Contact> contatos = [select id from Contact where Status_candidato__c != 'Aprovado direto' ];
        
        for(Contact con : contatos){
            con.Status_candidato__c = 'Aprovado direto';
        }
        
        update contatos;
        
        List<Task> tasks = [SELECT Id, Subject, Description FROM Task];
        
        System.assertEquals(2, tasks.size());
    }
    
    @isTest
    public static void doNotCreateTask(){
        Contact thor = new Contact(FirstName='Thor', LastName='Asgard', 
                                             NomeGuerra__c='Thor: rei  do trovao', 
                                             Status_candidato__c='Em análise',
                                         	MobilePhone = '11912345678',
                                         Nivel_de_poder__c = '7');
        
        List <Task> tasks = [select id from task where WhoId = :thor.Id];
        
        System.assertEquals(0, tasks.size());
        
    }
    
    @isTest
    public static void insertingNewContact(){
        Contact fulano = new Contact(FirstName='fulano', LastName='ciclano', 
                                             NomeGuerra__c='Thor: rei  do trovao', 
                                             Status_candidato__c='Aprovado direto',
                                         	MobilePhone = '11912345678',
                                         Nivel_de_poder__c = '7');
        insert fulano;
        
        Habilidade__c velocidade = new Habilidade__c(name='velocidade');
        Habilidade__c visaoNoturna = new Habilidade__c(name='visao noturna');
        List<Habilidade__c> hab = new List<Habilidade__c> {velocidade, visaoNoturna};
        insert hab;
        
        HabilidadeContato__c habcon_4 = new HabilidadeContato__c();
        habcon_4.Contato__c = fulano.Id;
		habcon_4.Habilidade__c = velocidade.Id;
        
        HabilidadeContato__c habcon_5 = new HabilidadeContato__c();
        habcon_5.Contato__c = fulano.Id;
		habcon_5.Habilidade__c = visaoNoturna.Id;
        
        List<HabilidadeContato__c> habilidades = new List<HabilidadeContato__c>{habcon_4, habcon_5};
        insert habilidades;
        
        List<HabilidadeContato__c> hab2 = [select id from HabilidadeContato__c where Contato__c = :fulano.Id];
        
        System.assertEquals(2, hab.size());
        
    }
    
}