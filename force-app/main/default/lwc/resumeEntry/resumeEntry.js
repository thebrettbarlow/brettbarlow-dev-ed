import { LightningElement, api, wire } from 'lwc';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import RESUME_ASSETS from '@salesforce/resourceUrl/resume';
import FROM_FIELD from '@salesforce/schema/Resume_Entry__c.From__c';
import LOCATION_FIELD from '@salesforce/schema/Resume_Entry__c.Location__c';
import LOGO_FIELD from '@salesforce/schema/Resume_Entry__c.Logo__c';
import NAME_FIELD from '@salesforce/schema/Resume_Entry__c.Name';
import ROLE_FIELD from '@salesforce/schema/Resume_Entry__c.Role__c';
import SKILLS_FIELD from '@salesforce/schema/Resume_Entry__c.Skills__c';
import SUMMARY_FIELD from '@salesforce/schema/Resume_Entry__c.Summary__c';
import TO_FIELD from '@salesforce/schema/Resume_Entry__c.To__c';

export default class ResumeEntry extends LightningElement {
  @api recordId;

  @wire(getRecord, {
    recordId: '$recordId',
    fields: [
      FROM_FIELD,
      LOCATION_FIELD,
      LOGO_FIELD,
      NAME_FIELD,
      ROLE_FIELD,
      SKILLS_FIELD,
      SUMMARY_FIELD,
      TO_FIELD
    ]
  })
  resumeEntry;

  get logo() {
    const logo = getFieldValue(this.resumeEntry.data, LOGO_FIELD);
    return logo ? `${RESUME_ASSETS}/${logo}` : null;
  }

  get title() {
    return this.resumeEntry.data.fields.Name.value;
  }

  get role() {
    return this.resumeEntry.data.fields.Role__c.value;
  }

  get from() {
    return this.resumeEntry.data.fields.From__c.value;
  }

  get to() {
    return this.resumeEntry.data.fields.To__c.value;
  }

  get hasEnded() {
    if (this.resumeEntry.data.fields.To__c.value) {
      return true;
    }
    return false;
  }

  get location() {
    return this.resumeEntry.data.fields.Location__c.value;
  }

  get skills() {
    if (!this.resumeEntry.data.fields.Skills__c.value) {
      return [];
    }

    return this.resumeEntry.data.fields.Skills__c.value
      .split(';')
      .map((skill, index) => ({ id: index, name: skill }));
  }

  get summary() {
    return this.resumeEntry.data.fields.Summary__c.value;
  }
}
