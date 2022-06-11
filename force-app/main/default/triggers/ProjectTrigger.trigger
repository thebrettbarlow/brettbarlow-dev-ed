trigger ProjectTrigger on Project__c(before insert, before update) {
  ProjectTriggerHandler triggerHandler = new ProjectTriggerHandler();
  switch on Trigger.operationType {
    when BEFORE_INSERT {
      triggerHandler.onBeforeInsert(Trigger.new);
    }
    when BEFORE_UPDATE {
      triggerHandler.onBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
  }
}
