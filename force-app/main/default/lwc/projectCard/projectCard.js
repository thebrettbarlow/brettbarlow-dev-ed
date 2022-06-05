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
  }

  navigateToProjectPage(event) {
    event.preventDefault();
    event.stopPropagation();

    this[NavigationMixin.Navigate](this.pageReference);
  }
}
