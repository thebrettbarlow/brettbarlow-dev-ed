@IsTest
private class ResumePicklistTest {
  private static ResumePicklist resumePicklist;

  static {
    resumePicklist = new ResumePicklist();
  }

  @IsTest
  private static void getDefaultValue() {
    System.assertNotEquals(
      null,
      resumePicklist.getDefaultValue(),
      'Default value was not assigned.'
    );
  }

  @IsTest
  private static void getValues() {
    insert new Resume__c(Name = 'Test Resume');
    Integer count = [SELECT COUNT() FROM Resume__c];

    VisualEditor.DynamicPickListRows rows = resumePicklist.getValues();

    System.assertEquals(
      count,
      rows.size(),
      'Picklist contains the incorrect number of options.'
    );
  }
}
