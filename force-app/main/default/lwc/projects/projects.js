import { LightningElement, api, wire } from 'lwc';
import getProjects from '@salesforce/apex/ProjectSelector.getProjects';
import { NavigationMixin } from 'lightning/navigation';

export default class Projects extends NavigationMixin(LightningElement) {
  @api projectPage;
  @wire(getProjects) projects;
}
