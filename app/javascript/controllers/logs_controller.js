import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
 static targets = ['card']

  connect() {
    // Fix problem go back page
    this.cardTarget.style.transform = 'rotateX(0) rotateY(0)';

    // mousemovecard

    this.cardTarget.addEventListener('mousemove', (e) => {
        const force = 10;
        const offsetX = (this.cardTarget.offsetWidth / 2 - e.layerX) / force;
        const offsetY = - (this.cardTarget.offsetHeight / 2 - e.layerY) / force;

        this.cardTarget.style.transform = `rotateX(${offsetY}deg) rotateY(${offsetX}deg)`;
      })
  }

  mouseEnter() {
    this.cardTarget.style.transitionDuration = '.05s'
  }

  mouseLeave(event) {
    this.cardTarget.style.transitionDuration = '1s'
    this.cardTarget.style.transform = 'rotateX(0) rotateY(0)';
  }
}
