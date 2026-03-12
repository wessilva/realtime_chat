import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-navbar"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.outsideClickHandler = this.closeMenu.bind(this)
    document.addEventListener("click", this.outsideClickHandler)
  }

  disconnect() {
    document.removeEventListener("click", this.outsideClickHandler)
  }

  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle("hidden")
  }

  closeMenu() {
    this.menuTarget.classList.add("hidden")
  }
}
