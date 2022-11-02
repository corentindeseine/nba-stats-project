import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
 static targets = ['g','p','t']

  connect() {
    console.log()
  }

  mouseOver(event) {
    if (event.currentTarget.innerHTML === 'Games reviews') {
      this.gTarget.classList.remove('invisible');
      this.gTarget.classList.add('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Players stats'){
      this.pTarget.classList.remove('invisible');
      this.pTarget.classList.add('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Teams'){
      this.tTarget.classList.remove('invisible');
      this.tTarget.classList.add('ball-hover');


      }
  }

  mouseOut(event) {
    if (event.currentTarget.innerHTML === 'Games reviews') {
      this.gTarget.classList.add('invisible');
      this.gTarget.classList.remove('ball-hover');


    } else if (event.currentTarget.innerHTML === 'Players stats'){
      this.pTarget.classList.add('invisible');
      this.pTarget.classList.remove('ball-hover');



    } else if (event.currentTarget.innerHTML === 'Teams'){
      this.tTarget.classList.add('invisible');
      this.tTarget.classList.remove('ball-hover');
      }
  }
}
