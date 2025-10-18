// Import Turbo (substitui rails-ujs)
import "@hotwired/turbo-rails"

// Import Stimulus
import { Application } from "@hotwired/stimulus"

// Inicializa Stimulus
const application = Application.start()

// Carrega todos os controllers automaticamente
const context = require.context("./controllers", true, /\.js$/)
context.keys().forEach((key) => {
  const controller = context(key).default
  if (controller) {
    const name = key.replace("./", "").replace(".js", "")
    application.register(name, controller)
  }
})
