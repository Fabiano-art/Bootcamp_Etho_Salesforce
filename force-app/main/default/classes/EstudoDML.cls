public class EstudoDML {
	
    public static void mainDML(){
        List<Contact> contatos = new List<Contact>();
        
        Contact con = new Contact(
            firstName = 'contato1 teste',
            lastName = 'Marvel',
            NomeGuerra__c = 'Contato 1 fodão'
        );
        
        Contact con2 = new Contact(
            firstName = 'monstrao',
            lastName = 'Marvel monstro ',
            NomeGuerra__c = 'Contato 2 fodão',
            Nivel_de_poder__c = '1'
        );
        
        Contact con3 = new Contact(
            firstName = 'contato3 teste',
            lastName = 'Marvel',
            NomeGuerra__c = 'aaaaaaaaa',
            Nivel_de_poder__c = '1'
        );
        
        contatos.add(con);
        contatos.add(con2);
        contatos.add(con3);
        
        // insertContact(contatos, true);
        
        List <Contact> today = [select id, firstname, lastname, NomeGuerra__c, 
                                      Nivel_de_poder__c from contact 
                                      where CreatedDate  = today];
        
        for (Integer i = 0; i < today.size(); i++){
			 today[i].NomeGuerra__c = 'algo'+i;
        }
        
        //updateContact(today, false);
        //upsertContact(contatos, true);
        
        List <Contact> toDelete = [select id, firstname, lastname, NomeGuerra__c, 
                                      Nivel_de_poder__c from contact 
                                      where CreatedDate  = today and NomeGuerra__c = 'Algo0'];
        //deleteContact(toDelete, true);
        
        List <Contact> toUndelete = [select id, firstname, lastname, NomeGuerra__c, 
                                      Nivel_de_poder__c from contact 
                                      where CreatedDate  = today and NomeGuerra__c = 'Algo0' all rows];
        undeleteContact(toUndelete, false);
    }
    
    public static void upsertContact(List<Contact> contatos, Boolean dbMethod){
        if(dbMethod){ // false = parcial || true = geral
            Database.UpsertResult[] results = Database.upsert(contatos /*,externalId*/, false);
            tratarUpsertResult(results);
        }
        else {
            upsert contatos; //passa o identificador para comparar e atualizar
            System.debug('Contatos: '+contatos);
        }
    }
    
    public static void insertContact(List<Contact> contatos, Boolean dbMethod){
        if(dbMethod){ // false = parcial || true = geral
            Database.SaveResult[] results = Database.insert(contatos, false);
            trataResult(results);
        }
        else {
            insert contatos;
            System.debug('Contatos: '+contatos);
        }
    }
    
    public static void updateContact(List<Contact> contatos, Boolean dbMethod){
        if(dbMethod){ // false = parcial || true = geral
            Database.SaveResult[] results = Database.update(contatos, false);
            trataResult(results);
        }
        else {
            update contatos;
            System.debug('Contatos: '+contatos);
        }
    }
    
    public static void deleteContact(List<Contact> contatos, Boolean dbMethod){
		if(dbMethod){ // false = parcial || true = geral
            Database.DeleteResult[] results = Database.delete(contatos, false);
            //trataResult(results);
        }
        else {
            delete contatos;
            System.debug('Contatos: '+contatos);
        }
    }
    
    public static void undeleteContact(List<Contact> contatos, Boolean dbMethod){
		if(dbMethod){ // false = parcial || true = geral
            Database.UndeleteResult[] results = Database.undelete(contatos, false);
            //trataResult(results);
        }
        else {
            undelete contatos;
            System.debug('Contatos: '+contatos);
        }
    }
    
    public static void trataResult(Database.SaveResult[] results){
        for ( Database.SaveResult result : results ){
            if(result.isSuccess()){
                System.debug('Success!!! ID do registro: '+result.getId());
            }
            else {
                for (Database.Error error : result.getErrors()){
                    System.debug('Something went wrong!!! Status code:'+error.getStatusCode()+'Message: '+error.getMessage());
                }
            }
        }
    }
    
    public static void tratarUpsertResult(Database.UpsertResult[] results){
        for ( Database.UpsertResult result : results ){
            if(result.isSuccess()){
                System.debug('Success!!! ID do registro: '+result.getId());
            }
            else {
                for (Database.Error error : result.getErrors()){
                    System.debug('Something went wrong!!! Status code:'+error.getStatusCode()+'Message: '+error.getMessage());
                }
            }
        }
    }
}