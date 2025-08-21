import { LightningElement } from 'lwc';

export default class Controls extends LightningElement {
  // factores para los botones dinámicos (luego usaremos <c-button/>)
  factors = [0, 2, 3, 4, 5, 6];

  handleAdd() {
    this.dispatchEvent(new CustomEvent('add'));
  }

  handleSubtract() {
    this.dispatchEvent(new CustomEvent('subtract'));
  }

  // Este handler lo reutilizamos tanto con botones nativos como con <c-button/>
  handleMultiply(event) {
    const factor = Number(event.target.dataset.factor ?? event.detail);
    this.dispatchEvent(new CustomEvent('multiply', { detail: factor }));
  }
}
