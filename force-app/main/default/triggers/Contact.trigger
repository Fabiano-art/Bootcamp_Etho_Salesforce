trigger Contact on Contact (before insert) {
	
    ContactTriggerHandler handler = new ContactTriggerHandler();
    
    switch on Trigger.operationType {
        when BEFORE_INSERT{
            handler.onBeforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE{
            handler.onBeforeUpdate(Trigger.new, Trigger.oldMap);
        }

        when AFTER_INSERT{
            handler.onAfterInsert(Trigger.new);
        }

        when AFTER_UPDATE{
            handler.onAfterUpdate(Trigger.new, Trigger.oldMap);
        }
        
        when BEFORE_DELETE {
            handler.onBeforeDelete(Trigger.old, Trigger.oldMap);
        }

    }
}