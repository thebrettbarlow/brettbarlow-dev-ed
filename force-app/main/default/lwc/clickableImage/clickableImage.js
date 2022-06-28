import { LightningElement, api } from 'lwc';

export default class ClickableImage extends LightningElement {
  @api href = '#';
  @api src;
  @api title;
  @api target = '_blank';
}
