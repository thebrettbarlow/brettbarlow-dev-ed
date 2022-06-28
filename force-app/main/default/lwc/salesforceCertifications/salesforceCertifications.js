import { LightningElement, api } from 'lwc';
import CERTIFICATIONS from '@salesforce/resourceUrl/salesforceCertifications';

export default class SalesforceCertifications extends LightningElement {
  _certifications;

  @api
  get certifications() {
    return this._certifications;
  }

  set certifications(value) {
    if (!value) {
      this._certifications = [];
      return;
    }

    this._certifications = value.split(';').map((certificationName, index) => ({
      id: index,
      title: `Certified ${certificationName}`,
      src: `${CERTIFICATIONS}/${certificationName.replaceAll(' ', '-')}.png`
    }));
  }
}
