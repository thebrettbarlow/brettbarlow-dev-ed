import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getResumeEntryIds from '@salesforce/apex/ResumeSelector.getResumeEntryIds';
import getUniqueSkillsFromResumeEntries from '@salesforce/apex/ResumeSelector.getUniqueSkillsFromResumeEntries';
import EMAIL_FIELD from '@salesforce/schema/Resume__c.Email__c';
import FIRST_NAME_FIELD from '@salesforce/schema/Resume__c.First_Name__c';
import GITHUB_FIELD from '@salesforce/schema/Resume__c.GitHub__c';
import HEADSHOT_FIELD from '@salesforce/schema/Resume__c.Headshot__c';
import LAST_NAME_FIELD from '@salesforce/schema/Resume__c.Last_Name__c';
import LINKEDIN_FIELD from '@salesforce/schema/Resume__c.LinkedIn__c';
import LOCATION_FIELD from '@salesforce/schema/Resume__c.Location__c';
import NAME_FIELD from '@salesforce/schema/Resume__c.Name';
import PHONE_FIELD from '@salesforce/schema/Resume__c.Phone__c';
import SALESFORCE_CERTIFICATIONS_FIELD from '@salesforce/schema/Resume__c.Salesforce_Certifications__c';
import SUMMARY_FIELD from '@salesforce/schema/Resume__c.Summary__c';
import TRAILHEAD_FIELD from '@salesforce/schema/Resume__c.Trailhead__c';
import WEBSITE_FIELD from '@salesforce/schema/Resume__c.Website__c';

export default class Resume extends LightningElement {
  @api recordId;

  @wire(getRecord, {
    recordId: '$recordId',
    fields: [
      EMAIL_FIELD,
      FIRST_NAME_FIELD,
      GITHUB_FIELD,
      HEADSHOT_FIELD,
      LAST_NAME_FIELD,
      LINKEDIN_FIELD,
      LOCATION_FIELD,
      NAME_FIELD,
      PHONE_FIELD,
      SALESFORCE_CERTIFICATIONS_FIELD,
      SUMMARY_FIELD,
      TRAILHEAD_FIELD,
      WEBSITE_FIELD
    ]
  })
  resume;

  @wire(getUniqueSkillsFromResumeEntries, { resumeId: '$recordId' })
  skills;

  @wire(getResumeEntryIds, { resumeId: '$recordId', type: 'Job' })
  jobEntryIds;

  @wire(getResumeEntryIds, { resumeId: '$recordId', type: 'Education' })
  educationEntryIds;

  get title() {
    return this.resume.data.fields.Name.value;
  }

  get headshot() {
    return this.resume.data.fields.Headshot__c.value;
  }

  get name() {
    const nameValues = [];
    const nameFields = [FIRST_NAME_FIELD, LAST_NAME_FIELD].map(
      (field) => field.fieldApiName
    );
    for (const nameField of nameFields) {
      if (this.resume.data.fields[nameField]) {
        nameValues.push(this.resume.data.fields[nameField].value);
      }
    }

    return nameValues.join(' ');
  }

  get location() {
    return this.resume.data.fields.Location__c.value;
  }

  get email() {
    return this.resume.data.fields.Email__c.value;
  }

  get phone() {
    return this.resume.data.fields.Phone__c.value;
  }

  get linkedin() {
    return this.resume.data.fields.LinkedIn__c.value;
  }

  get github() {
    return this.resume.data.fields.GitHub__c.value;
  }

  get trailhead() {
    return this.resume.data.fields.Trailhead__c.value;
  }

  get website() {
    return this.resume.data.fields.Website__c.value;
  }

  get summary() {
    return this.resume.data.fields.Summary__c.value;
  }

  get certifications() {
    return this.resume.data.fields.Salesforce_Certifications__c.value;
  }
}
