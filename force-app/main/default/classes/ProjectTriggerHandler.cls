public with sharing class ProjectTriggerHandler {
  private static final String STATUS_DONE = 'Done';

  public void onBeforeInsert(List<Project__c> projects) {
    for (Project__c project : projects) {
      if (isDone(project)) {
        setDone(project);
      }
    }
  }

  public void onBeforeUpdate(
    List<Project__c> projects,
    Map<Id, Project__c> idToOldProject
  ) {
    for (Project__c project : projects) {
      Project__c oldProject = idToOldProject.get(project.Id);
      if (project.Status__c != oldProject.Status__c) {
        if (isDone(project)) {
          setDone(project);
        } else {
          clearDone(project);
        }
      }
    }
  }

  private Boolean isDone(Project__c project) {
    return STATUS_DONE.equals(project.Status__c);
  }

  private void setDone(Project__c project) {
    project.Done__c = Date.today();
  }

  private void clearDone(Project__c project) {
    project.Done__c = null;
  }
}