import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['modal', 'dialog', 'title']

	open(event) {
    event.preventDefault();
    const body = document.querySelector('body');

    const url = event.currentTarget.getAttribute("data-modal-url")
    const title = event.currentTarget.getAttribute("data-modal-title")

    if (title) this.titleTarget.textContent = title
    if (url) this.dialogTarget.src = url

    body.classList.add("overflow-hidden");
    this.modalTarget.classList.add("show")
	}

  close() {
    document.querySelector('body').classList.remove("overflow-hidden")
    this.modalTarget.classList.remove("show")
    this.dialogTarget.src = ""
  }
}
