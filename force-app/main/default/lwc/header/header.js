import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { CurrentPageReference } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import WEBSITE_ASSETS from '@salesforce/resourceUrl/website';
import getNavigationMenuItems from '@salesforce/apex/NavigationMenuItemsController.getNavigationMenuItems';
import isGuestUser from '@salesforce/user/isGuest';
import basePath from '@salesforce/community/basePath';

export default class Header extends NavigationMixin(LightningElement) {
  @api navigationMenu;

  error;
  href = basePath;
  isLoaded;
  menuItems = [];
  publishedState;
  showHamburgerMenu;

  hamburgerIcon = `${WEBSITE_ASSETS}/hamburger-icon.png`;
  xIcon = `${WEBSITE_ASSETS}/x-icon.png`;

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

  navigateHome(event) {
    event.stopPropagation();
    event.preventDefault();
    this[NavigationMixin.Navigate]({
      type: 'comm__namedPage',
      attributes: {
        name: 'Home'
      }
    });
  }

  navigateToProjects(event) {
    event.stopPropagation();
    event.preventDefault();
    this[NavigationMixin.Navigate]({
      type: 'comm__namedPage',
      attributes: {
        name: 'Projects__c'
      }
    });
  }

  handleHamburgerMenuToggle(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    if (this.showHamburgerMenu) {
      this.showHamburgerMenu = false;
    } else {
      this.showHamburgerMenu = true;
    }
  }

  navigateHomeFromHamburgerMenu(event) {
    this.navigateHome(event);
    this.showHamburgerMenu = false;
  }

  navigateToProjectsFromHamburgerMenu(event) {
    this.navigateToProjects(event);
    this.showHamburgerMenu = false;
  }

  closeHamburgerMenu(event) {
    event.stopPropagation();
    this.showHamburgerMenu = false;
  }
}
