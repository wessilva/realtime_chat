import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {

  static targets = ["searchInput"]


  connect() {
    console.log("Search controller connected")
  }

  preventSubmit(event) {
    event.preventDefault();
    console.log("Form submit prevented")
  }

  findAll(){
    console.log(this.searchInputTarget.value);

    const inputValue = this.searchInputTarget.value.trim();

    fetch(`/search?query=${encodeURIComponent(inputValue)}`, {
      method: "GET", 
      headers: {
        "Content-Type": "application/json",
        // Accept:  "application/json",
       // Important for Turbo Stream:
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": this.getMetaValue("csrf-token")
      }
    })
    .then(response => {
      return response.text(); // Fetch API requires manual text conversion
    })
    .then(html => {
      // Insert HTML handling logic here if needed, but Turbo will manage updates automatically
      document.getElementById('found-results').innerHTML = html;
    })
    .catch(error => console.error("Error updating user:", error));
  }

  // <meta name="csrf-token" content="W3sp3xxxx">
  getMetaValue(name){
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute("content");
  }
}
