import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['panel', 'title', 'description', 'frame']

	open(event) {
    event.preventDefault()

    const url = event.currentTarget.getAttribute("data-drawer-url")
    const title = event.currentTarget.getAttribute("data-drawer-title")
    const description  = event.currentTarget.getAttribute("data-drawer-description")

    if (title) this.titleTarget.textContent = title
    if (description) this.titleTarget.textContent = description
    if (url) this.frameTarget.src = url
    this.panelTarget.setAttribute("open", "")
	}

  close() {
    this.panelTarget.removeAttribute("open")
    this.frameTarget.src = ""
  }

}
