import { LightningElement } from 'lwc';
import WEBSITE_ASSETS from '@salesforce/resourceUrl/website';
export default class About extends LightningElement {
  headshot = `${WEBSITE_ASSETS}/headshot.jpg`;
}
