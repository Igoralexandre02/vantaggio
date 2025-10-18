import { Application } from "@hotwired/stimulus"

// Inicializa Stimulus
const application = Application.start()

// Importa todos os controllers automaticamente
const context = require.context(".", true, /\.js$/)
context.keys().forEach((key) => {
  const controller = context(key).default
  if (controller) {
    const name = key.replace("./", "").replace(".js", "")
    application.register(name, controller)
  }
})
