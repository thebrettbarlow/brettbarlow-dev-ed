import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class ProjectCard extends NavigationMixin(LightningElement) {
  @api project;
  @api projectPage;

  pageReference;
  url;

  connectedCallback() {
    this.pageReference = {
      type: 'comm__namedPage',
      attributes: {
        name: this.projectPage
      },
      state: {
        recordId: this.project.Id
      }
    };
    this[NavigationMixin.GenerateUrl](this.pageReference).then((result) => {
      this.url = result;
    });

    // update to use slds-icon_medium
  }

  navigateToProjectPage(event) {
    console.log('navigateToProjectPage');
    event.preventDefault();
    event.stopPropagation();

    this[NavigationMixin.Navigate](this.pageReference);
  }
}
