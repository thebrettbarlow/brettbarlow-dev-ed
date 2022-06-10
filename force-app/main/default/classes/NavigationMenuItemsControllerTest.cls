@IsTest
private class NavigationMenuItemsControllerTest {
  @IsTest
  private static void constructor() {
    NavigationMenuItemsController controller = new NavigationMenuItemsController();
    System.assertNotEquals(
      null,
      controller,
      'Expected the constructor to return an instance.'
    );
  }

  @IsTest
  private static void getNavigationMenuItems_menuDefined_returnsItems() {
    List<NavigationLinkSet> linkSets = [
      SELECT DeveloperName
      FROM NavigationLinkSet
      LIMIT 1
    ];
    if (linkSets.isEmpty()) {
      throw new UnexpectedException(
        'At least 1 NavigationLinkSet is required to run this test.'
      );
    }
    String menuName = linkSets[0].DeveloperName;

    List<NavigationMenuItem> menuItems = NavigationMenuItemsController.getNavigationMenuItems(
      menuName,
      'Live'
    );

    System.assert(menuItems.size() > 0, 'Expected menu items to be returned.');
  }

  @IsTest
  private static void getNavigationMenuItems_noMenuDefined_returnsEmpty() {
    String menuName = '';

    List<NavigationMenuItem> menuItems = NavigationMenuItemsController.getNavigationMenuItems(
      menuName,
      'Live'
    );

    System.assertEquals(
      0,
      menuItems.size(),
      'Expected no menu items when the menu name is empty.'
    );
  }
}