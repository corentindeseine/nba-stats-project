import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
 static targets = ['logo','card']

  connect() {
    // Fix problem go back page
    this.cardTargets.forEach((element) => {
      element.classList.remove('hover-left-cards');
      element.classList.remove('hover-right-cards');
      element.style.transform = 'rotateX(0) rotateY(0)';
    })
    this.logoTargets.forEach(element => {
      element.classList.remove('hover-logo')
    });

    // mousemovecard

    this.cardTargets.forEach((card) => {
      card.addEventListener('mousemove', (e) => {
        const force = 10;
        const offsetX = (card.offsetWidth/2 - e.layerX)/ force;
        const offsetY = -(card.offsetHeight / 2 - e.layerY) / force;

        card.style.transform = `rotateX(${offsetY}deg) rotateY(${offsetX}deg)`;
      })
    })
  }

  mouseEnter(event) {
    this.cardTargets.forEach(card => {
      if (event.currentTarget.dataset.cardId === card.dataset.cardId) {
        card.style.transitionDuration = '.08s'
      }
    })
  }

  mouseLeave(event) {
    this.cardTargets.forEach(element => {
      if (event.currentTarget.dataset.cardId === element.dataset.cardId) {
        element.style.transitionDuration = '1s'
        element.style.transform = 'rotateX(0) rotateY(0)';
      }
    })
  }
}
