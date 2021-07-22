public class ContactTriggerHandler { 
	
    public void onBeforeInsert(List<Contact> newRecords, Map<id, Contact> mapOld){
        ContactTriggerHelper.formataCelular(newRecords, mapOld);
    } 
    
    public void onBeforeUpdate(List<Contact> newRecords, Map<id, Contact> mapOld){
        for( Contact con : newRecords ){
            System.debug(' before Contato new: '+ con);
            System.debug(' before Contato old: '+ mapOld.get(con.id));
        }
    }
    
    public void onAfterInsert(List<Contact> newRecords){
        //Schema.SObject.Contact.getRecordTypeInfosIdByDeveloperName('Vilao'.getRecordTypeId(
    }
    
    public void onAfterUpdate(List<Contact> newRecords, Map<id, Contact> mapOld){
        for( Contact con : newRecords ){
            System.debug(' after Contato new: '+ con);
            System.debug(' after Contato old: '+ mapOld.get(con.id));
        }
    }
    
    public void onBeforeDelete(List<Contact> oldRecords, Map<id, Contact> mapOld){
        //ContactTriggerHelper.
    }
}