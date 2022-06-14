public with sharing class ResumeSelector {
  @AuraEnabled(cacheable=true)
  public static List<Resume__c> getResumes() {
    return [SELECT Id, Name FROM Resume__c ORDER BY Name ASC];
  }
}
