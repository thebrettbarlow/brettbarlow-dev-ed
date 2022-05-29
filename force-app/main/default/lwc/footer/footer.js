import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getNavigationMenuItems from '@salesforce/apex/NavigationMenuItemsController.getNavigationMenuItems';
import isGuestUser from '@salesforce/user/isGuest';

/**
 * Footer for the website.
 *
 * TODO: Remove duplicate navigation menu logic in header and footer
 */
export default class Footer extends LightningElement {
  @api navigationMenu;

  error;
  isLoaded;
  menuItems = [];
  publishedState;

  @wire(getNavigationMenuItems, {
    menuName: '$navigationMenu',
    publishedState: '$publishedState'
  })
  wiredMenuItems({ error, data }) {
    if (data && !this.isLoaded) {
      this.menuItems = data
        .map((item, index) => {
          return {
            target: item.Target,
            id: index,
            label: item.Label,
            defaultListViewId: item.DefaultListViewId,
            type: item.Type,
            accessRestriction: item.AccessRestriction
          };
        })
        .filter((item) => {
          // Only show "Public" items if guest user
          return (
            item.accessRestriction === 'None' ||
            (item.accessRestriction === 'LoginRequired' && !isGuestUser)
          );
        });
      this.error = undefined;
      this.isLoaded = true;
    } else if (error) {
      this.error = error;
      this.menuItems = [];
      this.isLoaded = true;
      const message = `Navigation menu error: ${JSON.stringify(this.error)}`;
      const toastEvent = new ShowToastEvent({
        title: 'Error',
        message: message,
        variant: 'error'
      });
      this.dispatchEvent(toastEvent);
    }
  }

  @wire(CurrentPageReference)
  setCurrentPageReference(currentPageReference) {
    const app =
      currentPageReference &&
      currentPageReference.state &&
      currentPageReference.state.app;
    if (app === 'commeditor') {
      this.publishedState = 'Draft';
    } else {
      this.publishedState = 'Live';
    }
  }
}
