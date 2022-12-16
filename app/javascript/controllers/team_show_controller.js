import { Controller } from "@hotwired/stimulus"
import modal_game_controller from "./modal_game_controller";

export default class extends Controller {
  static targets= ['modalGame','winLoseMenu','win','lose','gameCard'];

  connect() {
  }

  launchGame(event) {
    var modalController = this.application.getControllerForElementAndIdentifier(
      this.modalGameTarget,
      "modal-game"
    );
    modalController.setCoHostContent(event.currentTarget.dataset)
    modalController.open();
  }

  showWinLoseMenu(event){
    event.currentTarget.classList.toggle("rotate")
    this.winLoseMenuTarget.classList.toggle('d-none')
  }

  sortByWin(event){
    event.currentTarget.classList.toggle("selected-option")
    this.loseTarget.classList.remove("selected-option")
    this.gameCardTargets.forEach(e => {

      if (e.dataset.teamName === e.dataset.homeName && parseInt(e.dataset.visitorScore) > parseInt(e.dataset.homeScore)) {
        e.classList.toggle('d-none')
      } else if ( e.dataset.teamName === e.dataset.visitorName && parseInt(e.dataset.visitorScore) < parseInt(e.dataset.homeScore)) {
        e.classList.toggle('d-none')
      } else {
        e.classList.remove('d-none')
      }
    });
  }

  sortByLose(event){
    event.currentTarget.classList.toggle("selected-option")
    this.winTarget.classList.remove("selected-option")
    this.gameCardTargets.forEach(e => {
      if (e.dataset.teamName === e.dataset.homeName && parseInt(e.dataset.visitorScore) < parseInt(e.dataset.homeScore)) {
        e.classList.toggle('d-none')
      } else if ( e.dataset.teamName === e.dataset.visitorName && parseInt(e.dataset.visitorScore) > parseInt(e.dataset.homeScore)) {
        e.classList.toggle('d-none')
      } else {
        e.classList.remove('d-none')
      }
    });
  }
}
