import { LightningElement, api } from 'lwc';

export default class ProjectTitle extends LightningElement {
  @api icon;
  @api iconSize;
  @api done;
}
