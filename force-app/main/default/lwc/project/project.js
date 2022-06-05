import { LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { CurrentPageReference } from 'lightning/navigation';
import DESIGN_FIELD from '@salesforce/schema/Project__c.Design__c';
import DONE_FIELD from '@salesforce/schema/Project__c.Done__c';
import GOAL_FIELD from '@salesforce/schema/Project__c.Goal__c';
import ICON_FIELD from '@salesforce/schema/Project__c.Icon__c';
import IMPLEMENTATION_FIELD from '@salesforce/schema/Project__c.Implementation__c';
import NAME_FIELD from '@salesforce/schema/Project__c.Name';
import REQUIREMENTS_FIELD from '@salesforce/schema/Project__c.Requirements__c';
import RETROSPECTIVE_FIELD from '@salesforce/schema/Project__c.Retrospective__c';
import TAGS_FIELD from '@salesforce/schema/Project__c.Tags__c';

export default class Project extends LightningElement {
  recordId;

  @wire(CurrentPageReference)
  pageReference({ state }) {
    if (state && state.recordId) {
      this.recordId = state.recordId;
    }
  }

  @wire(getRecord, {
    recordId: '$recordId',
    fields: [
      DESIGN_FIELD,
      DONE_FIELD,
      GOAL_FIELD,
      ICON_FIELD,
      IMPLEMENTATION_FIELD,
      NAME_FIELD,
      REQUIREMENTS_FIELD,
      RETROSPECTIVE_FIELD,
      TAGS_FIELD
    ]
  })
  project;

  get design() {
    return this.project.data.fields.Design__c.value;
  }

  get done() {
    return this.project.data.fields.Done__c.value;
  }

  get goal() {
    return this.project.data.fields.Goal__c.value;
  }

  get icon() {
    return this.project.data.fields.Icon__c.value;
  }

  get implementation() {
    return this.project.data.fields.Implementation__c.value;
  }

  get name() {
    return this.project.data.fields.Name.value;
  }

  get requirements() {
    return this.project.data.fields.Requirements__c.value;
  }

  get retrospective() {
    return this.project.data.fields.Retrospective__c.value;
  }

  get tags() {
    return this.project.data.fields.Tags__c.value;
  }
}
