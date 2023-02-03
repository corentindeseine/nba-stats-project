import { Controller } from "@hotwired/stimulus"
import $ from 'jquery';

export default class extends Controller {
 static targets = ['playerOneForm',
                   'playerOneName',
                   'playerOneImage',
                   'playerOneTeam',
                   'playerOnePosition',

                   'playerTwoForm',
                   'playerTwoName',
                   'playerTwoImage',
                   'playerTwoTeam',
                   'playerTwoPosition',

                   'playerOneCard',
                   'playerTwoCard',

                    'playerCardAfter']

  connect() {

    // AJOUT D'UNE ZONE DE TEXTE DANS LES INPUT DU FORM

    // $('.player-one-input').select2({
    //     width: '100%',
    //     allowClear: true,
    //     minimumResultsForSearch: -1
    // });


    // // Appearance of card and table after submit

    //   this.playerCardAfterTargets.forEach(element => {
    //     element.classList.add('versus-player-card-after')
    //   });

    // AJAX POUR RECUPERER LA CARD DU PLAYER AVANT ENVOIE DU SEARCH

    var playerOneInformations = { name: this.playerOneNameTarget,
                                  team: this.playerOneTeamTarget,
                                  position: this.playerOnePositionTarget,
                                  image: this.playerOneImageTarget
                                }

    var playerTwoInformations = { name: this.playerTwoNameTarget,
                                  team: this.playerTwoTeamTarget,
                                  position: this.playerTwoPositionTarget,
                                  image: this.playerTwoImageTarget
                                }

    const playerOneCard = this.playerOneCardTarget
    const playerTwoCard = this.playerTwoCardTarget


    this.playerOneFormTarget.addEventListener("change", function() {
      getPlayersInformations(playerOneInformations, this.value)
      playerOneCard.classList.remove('d-none')
    });

    this.playerTwoFormTarget.addEventListener("change", function() {
      getPlayersInformations(playerTwoInformations, this.value)
      playerTwoCard.classList.remove('d-none')
    });


    // EFFET CARD MOUSE MOVE

    this.playerOneCardTarget.style.transform = 'rotateX(0) rotateY(0)';
    this.playerOneCardTarget.addEventListener('mousemove', (e) => {
      const force = 10;
      const offsetX = (this.playerOneCardTarget.offsetWidth / 2 - e.layerX) / force;
      const offsetY = - (this.playerOneCardTarget.offsetHeight / 2 - e.layerY) / force;

      this.playerOneCardTarget.style.transform = `rotateX(${offsetY}deg) rotateY(${offsetX}deg)`;
    })


    this.playerTwoCardTarget.style.transform = 'rotateX(0) rotateY(0)';
    this.playerTwoCardTarget.addEventListener('mousemove', (e) => {
      const force = 10;
      const offsetX = (this.playerTwoCardTarget.offsetWidth / 2 - e.layerX) / force;
      const offsetY = - (this.playerTwoCardTarget.offsetHeight / 2 - e.layerY) / force;

      this.playerTwoCardTarget.style.transform = `rotateX(${offsetY}deg) rotateY(${offsetX}deg)`;
    })
  }

  mouseEnter() {
    this.playerOneCardTarget.style.transitionDuration = '.05s'
    this.playerTwoCardTarget.style.transitionDuration = '.05s'
  }

  mouseLeave() {
    this.playerOneCardTarget.style.transitionDuration = '1s'
    this.playerOneCardTarget.style.transform = 'rotateX(0) rotateY(0)';

    this.playerTwoCardTarget.style.transitionDuration = '1s'
    this.playerTwoCardTarget.style.transform = 'rotateX(0) rotateY(0)';
  }
}


const getPlayersInformations = (playerInformations, id) => {
  fetch(`/players/${id}`)
  .then(response => response.json())
  .then(data => {
    playerInformations.image.src  = data.image_url;
    playerInformations.name.innerHTML = '53';
    playerInformations.team.innerHTML = data.team.name

    if (data.position === 'G') {
      playerInformations.position.innerHTML = 'Guard'
    } else if (data.position === 'F') {
      playerInformations.position.innerHTML = 'Forward'
    } else if (data.position === 'C') {
      playerInformations.position.innerHTML = 'Center'
    } else {
      playerInformations.position.innerHTML = data.position
    }
  });
}
