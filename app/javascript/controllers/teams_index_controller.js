import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
 static targets = ['logo','card']

  connect() {
  }

  mouseOver(event) {
    if ([3,4,7,8,11,12,15,16,19,20,23,24,27,28].includes(parseInt(event.currentTarget.dataset.cardId)) ) {
      event.currentTarget.classList.add('hover-right-cards')
    } else {
      event.currentTarget.classList.add('hover-left-cards')
    }

    this.logoTargets.forEach(element => {
      if (event.currentTarget.dataset.cardId === element.dataset.cardId) {
        element.classList.add('hover-logo')
      }
    })
  }

  mouseOut(event) {
    event.currentTarget.classList.remove('hover-left-cards')
    event.currentTarget.classList.remove('hover-right-cards')

    this.logoTargets.forEach(element => {
      if (event.currentTarget.dataset.cardId === element.dataset.cardId) {
        element.classList.remove('hover-logo')
      }
    })
  }
}
