@IsTest
private class ProjectSelectorTest {
  @IsTest
  private static void getProjects_returnsOnlyDoneProjects() {
    List<Project__c> projects = new List<Project__c>();
    projects.add(
      new Project__c(Name = 'In Progress Project', Status__c = 'In Progress')
    );
    projects.add(new Project__c(Name = 'Done Project', Status__c = 'Done'));
    insert projects;

    Test.startTest();
    List<Project__c> result = ProjectSelector.getProjects();
    Test.stopTest();

    System.assertEquals(1, result.size(), 'Should return 1 Project.');
    System.assertEquals(
      'Done',
      result[0].Status__c,
      'Expected the Project\'s Status to be Done.'
    );
  }
}
