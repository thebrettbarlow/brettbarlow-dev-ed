@IsTest
private class NavigationLinkSetPickListTest {
  private static NavigationLinkSetPickList navigationLinkSetPickList;

  static {
    navigationLinkSetPickList = new NavigationLinkSetPickList();
  }

  @IsTest
  private static void getDefaultValue() {
    System.assertNotEquals(
      null,
      navigationLinkSetPickList.getDefaultValue(),
      'Default value was not assigned.'
    );
  }

  @IsTest
  private static void getValues() {
    Integer count = [SELECT COUNT() FROM NavigationLinkSet];

    VisualEditor.DynamicPickListRows rows = navigationLinkSetPickList.getValues();

    System.assertEquals(
      count,
      rows.size(),
      'Picklist contains the incorrect number of options.'
    );
  }
}