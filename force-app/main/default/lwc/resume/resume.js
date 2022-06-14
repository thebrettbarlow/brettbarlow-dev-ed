import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import FIRST_NAME_FIELD from '@salesforce/schema/Resume__c.First_Name__c';
import HEADSHOT_FIELD from '@salesforce/schema/Resume__c.Headshot__c';
import LAST_NAME_FIELD from '@salesforce/schema/Resume__c.Last_Name__c';
import NAME_FIELD from '@salesforce/schema/Resume__c.Name';

export default class Resume extends LightningElement {
  @api resumeId;

  @wire(getRecord, {
    recordId: '$resumeId',
    fields: [NAME_FIELD]
  })
  resume;

  get title() {
    return this.resume.data.fields.Name.value;
  }

  get headshot() {
    console.log(this.resume.data.fields.Headshot__c.value);
    return '';
  }

  get name() {
    const nameValues = [];
    for (const namePart of [FIRST_NAME_FIELD, LAST_NAME_FIELD]) {
      if (this.resume.data.fields[namePart]) {
        nameValues.push(this.resume.data.fields[namePart].value);
      }
    }

    return nameValues.join(' ');
  }
}
