import { LightningElement, api } from 'lwc';

export default class Button extends LightningElement {
  @api label;
  @api icon;

  handleButton() {
    // burbujea para llegar al lightning-layout-item de Controls
    this.dispatchEvent(new CustomEvent('buttonclick', { bubbles: true }));
  }
}
