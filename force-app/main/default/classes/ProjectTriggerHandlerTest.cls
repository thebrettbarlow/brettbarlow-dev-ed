@IsTest
private class ProjectTriggerHandlerTest {
  @IsTest
  private static void onBeforeInsert_projectStatusDone_doneIsToday() {
    Project__c project = new Project__c(
      Name = 'Test Project',
      Status__c = 'Done'
    );

    Test.startTest();
    insert project;
    Test.stopTest();

    Project__c result = [
      SELECT Done__c
      FROM Project__c
      WHERE Id = :project.Id
      LIMIT 1
    ];

    System.assertEquals(
      Date.today(),
      result.Done__c,
      'The Done field should be today\'s date when the project has the Status field set to Done.'
    );
  }

  @IsTest
  private static void onBeforeInsert_projectStatusNotStarted_doneIsNull() {
    Project__c project = new Project__c(
      Name = 'Test Project',
      Status__c = 'Not Started'
    );

    Test.startTest();
    insert project;
    Test.stopTest();

    Project__c result = [
      SELECT Done__c
      FROM Project__c
      WHERE Id = :project.Id
      LIMIT 1
    ];

    System.assertEquals(
      null,
      result.Done__c,
      'The Done field should not be set when the project does not have the Status field set to Done.'
    );
  }

  @IsTest
  private static void onBeforeInsert_projectStatusNull_doneIsNull() {
    Project__c project = new Project__c(
      Name = 'Test Project',
      Status__c = null
    );

    Test.startTest();
    insert project;
    Test.stopTest();

    Project__c result = [
      SELECT Done__c
      FROM Project__c
      WHERE Id = :project.Id
      LIMIT 1
    ];

    System.assertEquals(
      null,
      result.Done__c,
      'The Done field should not be set when the project has the Status field set to null.'
    );
  }

  @IsTest
  private static void onBeforeUpdate_projectStatusDone_doneIsToday() {
    Project__c project = new Project__c(
      Name = 'Test Project',
      Status__c = 'In Progress'
    );
    insert project;
    project.Status__c = 'Done';

    Test.startTest();
    update project;
    Test.stopTest();

    Project__c result = [
      SELECT Done__c
      FROM Project__c
      WHERE Id = :project.Id
      LIMIT 1
    ];

    System.assertEquals(
      Date.today(),
      result.Done__c,
      'The Done field should be today\'s date when the project Status field is updated to Done.'
    );
  }

  @IsTest
  private static void onBeforeUpdate_projectStatusInProgress_doneIsNull() {
    Project__c project = new Project__c(
      Name = 'Test Project',
      Status__c = 'Not Started'
    );
    insert project;
    project.Status__c = 'In Progress';

    Test.startTest();
    update project;
    Test.stopTest();

    Project__c result = [
      SELECT Done__c
      FROM Project__c
      WHERE Id = :project.Id
      LIMIT 1
    ];

    System.assertEquals(
      null,
      result.Done__c,
      'The Done field should not be set when the project Status field is updated to In Progress.'
    );
  }

  @IsTest
  private static void onBeforeUpdate_projectStatusNull_doneIsNull() {
    Project__c project = new Project__c(
      Name = 'Test Project',
      Status__c = 'Not Started'
    );
    insert project;
    project.Status__c = null;

    Test.startTest();
    update project;
    Test.stopTest();

    Project__c result = [
      SELECT Done__c
      FROM Project__c
      WHERE Id = :project.Id
      LIMIT 1
    ];

    System.assertEquals(
      null,
      result.Done__c,
      'The Done field should not be set when the project Status field is updated to null.'
    );
  }
}