import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hover-cards"
export default class extends Controller {
  static targets = ["upcoming", "past"]
  connect() {
    console.log("connected");
  }

  showUpcoming() {
    this.upcomingTarget.classList.add("active-section");
    this.pastTarget.classList.remove("active-section");
  }

  showPast() {
    this.pastTarget.classList.add("active-section");
    this.upcomingTarget.classList.remove("active-section");
  }
}
