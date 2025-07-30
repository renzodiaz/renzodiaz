import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["input", "output", "upload"]

  update() {
    const file = this.inputTarget.files[0]
    if (file && file.type.match(/^image\//)) {
      const reader = new FileReader()
      reader.onload = e => {
        this.outputTarget.src = e.target.result
        this.uploadTarget.classList.add("hidden")
      }
      reader.readAsDataURL(file)
    } else {
      this.outputTarget.src = ""
    }
  }
}
