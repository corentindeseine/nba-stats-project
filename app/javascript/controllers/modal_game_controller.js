import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['visitorLogo',
                    'visitorName',
                    'visitorScore',
                    'homeLogo',
                    'homeName',
                    'homeScore']

  setCoHostContent(data) {
    this.visitorLogoTarget.src= data.visitorLogo;
    this.homeLogoTarget.src = data.homeLogo;

    this.visitorNameTarget.innerHTML = data.visitorName;
    this.homeNameTarget.innerHTML = data.homeName;

    this.visitorScoreTarget.innerHTML = data.visitorScore;
    this.homeScoreTarget.innerHTML = data.homeScore;
  }

  open() {
    document.body.classList.add("modal-open");
    this.element.setAttribute("style", "display: block;");
    this.element.classList.add("show");
    document.body.innerHTML += '<div class="modal-backdrop fade show"></div>';
  }

  close() {
    document.body.classList.remove("modal-open");
    this.element.removeAttribute("style");
    this.element.classList.remove("show");
    document.getElementsByClassName("modal-backdrop")[0].remove();
  }

}
