import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
 static targets = ['games_reviews','players_stats','players_vs','teams']

  connect() {
    this.games_reviewsTarget.classList.add('invisible');
    this.games_reviewsTarget.classList.remove('ball-hover');

    this.players_statsTarget.classList.add('invisible');
    this.players_statsTarget.classList.remove('ball-hover');

    this.players_vsTarget.classList.add('invisible');
    this.players_vsTarget.classList.remove('ball-hover');

    this.teamsTarget.classList.add('invisible');
    this.teamsTarget.classList.remove('ball-hover');
  }

  mouseOver(event) {
    if (event.currentTarget.innerHTML === 'Games reviews') {
      this.games_reviewsTarget.classList.remove('invisible');
      this.games_reviewsTarget.classList.add('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Players stats'){
      this.players_statsTarget.classList.remove('invisible');
      this.players_statsTarget.classList.add('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Players VS'){
      this.players_vsTarget.classList.remove('invisible');
      this.players_vsTarget.classList.add('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Teams'){
      this.teamsTarget.classList.remove('invisible');
      this.teamsTarget.classList.add('ball-hover');
    }
  }

  mouseOut(event) {
    if (event.currentTarget.innerHTML === 'Games reviews') {
      this.games_reviewsTarget.classList.add('invisible');
      this.games_reviewsTarget.classList.remove('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Players stats'){
      this.players_statsTarget.classList.add('invisible');
      this.players_statsTarget.classList.remove('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Players VS'){
      this.players_vsTarget.classList.add('invisible');
      this.players_vsTarget.classList.remove('ball-hover');

    } else if (event.currentTarget.innerHTML === 'Teams'){
      this.teamsTarget.classList.add('invisible');
      this.teamsTarget.classList.remove('ball-hover');
    }
  }
}
