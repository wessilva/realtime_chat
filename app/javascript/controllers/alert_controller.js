import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["hideable"]

  connect(){
  }

  hideMe() {
    console.log(this)
    this.hideableTarget.classList.add("hidden")
  }
  
}
