import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
 static targets = ['games','players','players_vs','teams']

  connect() {
    this.gamesTarget.classList.add('invisible');
    this.gamesTarget.classList.remove('ball-hover');

    this.playersTarget.classList.add('invisible');
    this.playersTarget.classList.remove('ball-hover');

    this.players_vsTarget.classList.add('invisible');
    this.players_vsTarget.classList.remove('ball-hover');

    this.teamsTarget.classList.add('invisible');
    this.teamsTarget.classList.remove('ball-hover');
  }

  mouseOver(event) {
    if (event.currentTarget.innerHTML === 'Games') {
      this.gamesTarget.classList.remove('invisible');
      this.gamesTarget.classList.add('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Players'){
      this.playersTarget.classList.remove('invisible');
      this.playersTarget.classList.add('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Players VS'){
      this.players_vsTarget.classList.remove('invisible');
      this.players_vsTarget.classList.add('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Teams'){
      this.teamsTarget.classList.remove('invisible');
      this.teamsTarget.classList.add('ball-hover');
    }
  }

  mouseOut(event) {
    if (event.currentTarget.innerHTML === 'Games') {
      this.gamesTarget.classList.add('invisible');
      this.gamesTarget.classList.remove('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Players'){
      this.playersTarget.classList.add('invisible');
      this.playersTarget.classList.remove('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Players VS'){
      this.players_vsTarget.classList.add('invisible');
      this.players_vsTarget.classList.remove('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Teams'){
      this.teamsTarget.classList.add('invisible');
      this.teamsTarget.classList.remove('ball-hover');
    }
  }
}
