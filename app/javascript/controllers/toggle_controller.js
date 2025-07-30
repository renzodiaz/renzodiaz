import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.outsideClickListener = this.handleOutsideClick.bind(this)
    document.addEventListener("click", this.outsideClickListener)
  }

  disconnect() {
    document.removeEventListener("click", this.outsideClickListener)
  }

  switch(event) {
    event.stopPropagation()

    if (this.menuTarget.classList.contains("opacity-0")) {
      this.showMenu()

    } else {
      this.hideMenu()
    }
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.hideMenu()
    }
  }

  showMenu() {
    this.menuTarget.classList.remove("opacity-0", "scale-95", "pointer-events-none")
    this.menuTarget.classList.add("opacity-100", "scale-100")
  }

  hideMenu() {
    this.menuTarget.classList.remove("opacity-100", "scale-100")
    this.menuTarget.classList.add("opacity-0", "scale-95", "pointer-events-none")
  }
}
