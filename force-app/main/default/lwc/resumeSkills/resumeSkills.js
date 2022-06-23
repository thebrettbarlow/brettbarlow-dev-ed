import { api, LightningElement } from 'lwc';

export default class ResumeSkills extends LightningElement {
  _skills;

  @api
  get skills() {
    return this._skills;
  }

  set skills(value) {
    if (!value) {
      this._skills = [];
      return;
    }

    // TODO(brettbarlow): debug why this is getting called twice
    if (Array.isArray(value)) {
      this._skills = value;
      return;
    }

    this._skills = value
      .split(';')
      .map((skill, index) => ({ id: index, name: skill }));
  }
}
