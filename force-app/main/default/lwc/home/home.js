import { LightningElement } from 'lwc';
import DEV_USER_GROUP from '@salesforce/resourceUrl/devUserGroup';
import DREAMFORCE_2018 from '@salesforce/resourceUrl/dreamforce2018';
import DREAMFORCE_2019 from '@salesforce/resourceUrl/dreamforce2019';

export default class Home extends LightningElement {
  devUserGroup = DEV_USER_GROUP;
  dreamforce2018 = DREAMFORCE_2018;
  dreamforce2019 = DREAMFORCE_2019;
}
