import { Controller } from "@hotwired/stimulus"
import modal_game_controller from "./modal_game_controller";

export default class extends Controller {
  static targets= ['modalGame','WinLoseMenu'];

  connect() {
    console.log('hello')
  }

  launchGame(event) {
    var modalController = this.application.getControllerForElementAndIdentifier(
      this.modalGameTarget,
      "modal-game"
    );
    modalController.setCoHostContent(event.currentTarget.dataset)
    modalController.open();
  }

  ShowWinLoseMenu(event){
    console.log(event.currentTarget)
    event.currentTarget.classList.toggle("rotate")
    this.WinLoseMenuTarget.classList.toggle('d-none')
  }
}
