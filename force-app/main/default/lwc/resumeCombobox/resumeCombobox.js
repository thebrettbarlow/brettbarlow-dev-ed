import { LightningElement, api, wire } from 'lwc';
import getResumes from '@salesforce/apex/ResumeSelector.getResumes';

export default class ResumeCombobox extends LightningElement {
  @api value;
  options;
  error;

  @wire(getResumes)
  wiredResumes({ error, data }) {
    if (data) {
      this.options = data.map((resume) => ({
        label: resume.Name,
        value: resume.Id
      }));
      this.error = undefined;
    } else if (error) {
      this.options = undefined;
      this.error = error;
    }
  }

  handleChange(event) {
    this.dispatchEvent(
      new CustomEvent('change', { detail: { recordId: event.detail.value } })
    );
  }
}
