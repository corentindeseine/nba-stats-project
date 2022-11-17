import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["teams"]
  static values = { controller: String }

  connect() {
    console.log(this.controllerValue)

    if (this.controllerValue == 'teams') {
      this.teamsTarget.classList.add('current-navbar-link')
    }
  }
}
