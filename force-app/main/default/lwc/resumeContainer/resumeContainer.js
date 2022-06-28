import { api, LightningElement, wire } from 'lwc';
import getResumeIdByName from '@salesforce/apex/ResumeSelector.getResumeIdByName';

export default class ResumeContainer extends LightningElement {
  @api resumeName;

  @wire(getResumeIdByName, { resumeName: '$resumeName' })
  resumeId;
}
