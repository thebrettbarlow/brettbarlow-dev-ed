import { LightningElement } from 'lwc';
import DREAMFORCE_2018_2 from '@salesforce/resourceUrl/dreamforce2018_2';
import DREAMFORCE_2019_1 from '@salesforce/resourceUrl/dreamforce2019_1';
import DREAMFORCE_2019_2 from '@salesforce/resourceUrl/dreamforce2019_2';

export default class Home extends LightningElement {
  dreamforce2018_2 = DREAMFORCE_2018_2;
  dreamforce2019_1 = DREAMFORCE_2019_1;
  dreamforce2019_2 = DREAMFORCE_2019_2;
}
