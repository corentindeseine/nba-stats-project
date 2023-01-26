import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
 static targets = ["playerOneForm",'playerOne','playerTwo']

  connect() {
    console.log(this.playerOneTarget.innerHTML)
    var selectedPlayerId;

    this.playerOneFormTarget.addEventListener("change", function() {
      selectedPlayerId = this.value;
      console.log(this.value);

      fetch(`/players/${selectedPlayerId}`)
        .then(response => response.json())
        .then(data => {
          console.log(data)
        // // Utilisez les données pour afficher l'image du joueur et les autres informations sur la vue "versus"
        // document.querySelector("#player-image").src = data.image_url;
        // document.querySelector("#player-team").innerHTML = data.team.name;
        // document.querySelector("#player-average-pts").innerHTML = data.average_pts;
      });
    });
  }
}
