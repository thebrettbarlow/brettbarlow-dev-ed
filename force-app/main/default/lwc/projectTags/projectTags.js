import { LightningElement, api } from 'lwc';

export default class ProjectTags extends LightningElement {
  _tags = [];

  get tags() {
    return this._tags;
  }
  @api
  set tags(value) {
    if (!value) {
      this._tags = [];
      return;
    }
    if (this._tags !== value) {
      this._tags = value
        .split(';')
        .map((tag, index) => ({ id: index, label: tag }));
    }
  }
}
