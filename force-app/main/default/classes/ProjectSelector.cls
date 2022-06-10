public with sharing class ProjectSelector {
  @AuraEnabled(cacheable=true)
  public static List<Project__c> getProjects() {
    return [
      SELECT Id, Name, Goal__c, Icon__c, Tags__c, Status__c, Done__c
      FROM Project__c
      WHERE Status__c = 'Done'
      ORDER BY Done__c DESC
    ];
  }
}