import { LightningElement, api } from 'lwc';

export default class ProjectSection extends LightningElement {
  @api heading;
  @api content;
}
