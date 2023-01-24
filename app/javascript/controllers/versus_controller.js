import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
 static targets = ["playerOneForm",'playerOne','playerTwo']

  connect() {
    console.log(this.playerOneTarget.innerHTML)
    var selectedPlayer;

    this.playerOneFormTarget.addEventListener("change", function() {
      selectedPlayer = this.value;
      console.log(selectedPlayer)
    });

  }
}
