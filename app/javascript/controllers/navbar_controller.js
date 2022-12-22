import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["team","game","player","navbarMenu"]
  static values = { controller: String }

  connect() {
    if (this.controllerValue == 'teams') {
      this.teamTarget.classList.add('current-navbar-link')
    }
      else if (this.controllerValue == 'players') {
      this.playerTarget.classList.add('current-navbar-link')
    }
      else if (this.controllerValue == 'games') {
      this.gameTarget.classList.add('current-navbar-link')
    }
  }

  showMenu() {
    this.navbarMenuTarget.classList.toggle('menu-open')
  }
}
