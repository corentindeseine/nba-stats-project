import { Controller } from "@hotwired/stimulus"
import modal_game_controller from "./modal_game_controller";

export default class extends Controller {
  static targets= ['modalGame'];

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
}
