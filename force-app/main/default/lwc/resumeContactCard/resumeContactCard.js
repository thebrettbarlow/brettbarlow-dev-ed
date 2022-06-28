import { LightningElement, api } from 'lwc';
import RESUME_ASSETS from '@salesforce/resourceUrl/resume';

export default class ResumeContactCard extends LightningElement {
  @api headshot;
  @api name;
  @api location;
  @api email;
  @api phone;

  get headshotSrc() {
    return `${RESUME_ASSETS}/${this.headshot}`;
  }
}
