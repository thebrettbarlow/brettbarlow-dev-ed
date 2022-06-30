import { LightningElement } from 'lwc';
import WEBSITE_ASSETS from '@salesforce/resourceUrl/website';

export default class Home extends LightningElement {
  devUserGroup = `${WEBSITE_ASSETS}/dreamforce-2018-2.jpg`;
  dreamforce2018 = `${WEBSITE_ASSETS}/dreamforce-2018.jpg`;
  dreamforce2019 = `${WEBSITE_ASSETS}/dreamforce-2019.jpg`;
}
