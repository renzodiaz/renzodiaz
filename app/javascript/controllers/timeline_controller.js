import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ "box" ]

  connect() {
    window.addEventListener('scroll', () => this.displayBox())
  }

  disconnect() {
    window.removeEventListener('scroll', this.displayBox)
  }

  displayBox() {
    const triggerBottom = (window.innerHeight / 5) * 4

    if (this.boxTargets.length > 0 ) {
      this.boxTargets.forEach((box) => {

        const topBox = box.getBoundingClientRect().top

        if (topBox <  triggerBottom) {
          box.classList.add("show")
        } else {
          box.classList.remove("show")
        }
      })

    }
  }
}
