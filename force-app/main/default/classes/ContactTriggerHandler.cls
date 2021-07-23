public class ContactTriggerHandler { 
	
    public void onBeforeInsert(List<Contact> newRecords){
        new ContactTriggerHelper().formataCelular(newRecords);
    } 
    
    public void onBeforeUpdate(List<Contact> newRecords, Map<id, Contact> mapOld){
    }
    
    public void onAfterInsert(List<Contact> newRecords){
        //Schema.SObject.Contact.getRecordTypeInfosIdByDeveloperName('Vilao'.getRecordTypeId)
    }
    
    public void onAfterUpdate(List<Contact> newRecords, Map<id, Contact> mapOld){
    }
    
    public void onBeforeDelete(List<Contact> oldRecords, Map<id, Contact> mapOld){
    }
}