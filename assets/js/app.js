// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//
// If you have dependencies that try to import CSS, esbuild will generate a separate `app.css` file.
// To load it, simply add a second `<link>` to your `root.html.heex` file.

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import {hooks as colocatedHooks} from "phoenix-colocated/caden_barton_showcase"
import topbar from "../vendor/topbar"

const themeStorageKey = "phx:theme"
const allowedThemes = ["dark", "light"]

const normalizeTheme = theme => allowedThemes.includes(theme) ? theme : "dark"

const setTheme = theme => {
  const next = normalizeTheme(theme)
  localStorage.setItem(themeStorageKey, next)
  document.documentElement.setAttribute("data-theme", next)
  window.dispatchEvent(new CustomEvent("cbs:theme-changed", {detail: {theme: next}}))
}

const initialTheme = normalizeTheme(localStorage.getItem(themeStorageKey))
setTheme(initialTheme)

window.addEventListener("storage", event => {
  if (event.key === themeStorageKey) {
    setTheme(event.newValue)
  }
})

window.addEventListener("phx:set-theme", event => {
  setTheme(event.target.dataset.phxTheme)
})

const Hooks = {
  Typewriter: {
    mounted() {
      this.text = this.el.dataset.text || ""
      this.index = 0
      this.active = true
      this.el.textContent = ""

      if (this.text.length === 0) {
        this.pushEvent("welcome_typed", {})
        return
      }

      this.typeNext()
    },
    destroyed() {
      this.active = false
      if (this.timer) {
        clearTimeout(this.timer)
      }
    },
    typeNext() {
      if (!this.active) return

      if (this.index >= this.text.length) {
        this.active = false
        this.pushEvent("welcome_typed", {})
        return
      }

      this.el.textContent = this.text.slice(0, this.index + 1)
      const currentChar = this.text[this.index]
      this.index += 1
      const delay = this.delayFor(currentChar)

      this.timer = setTimeout(() => this.typeNext(), delay)
    },
    delayFor(char) {
      const fast = 40 + Math.random() * 40

      if (".!?".includes(char)) return 380 + Math.random() * 200
      if (",;:".includes(char)) return 220 + Math.random() * 160
      if (char === " ") return 50 + Math.random() * 70

      return fast
    },
  },
  HiringManagerTourPersistence: {
    mounted() {
      this.storageKey = "cbs:hiring_manager_tour:v1"

      try {
        const raw = localStorage.getItem(this.storageKey)
        if (raw) {
          const parsed = JSON.parse(raw)
          this.pushEvent("tour_state_loaded", {state: parsed})
        }
      } catch (_error) {
        // ignore malformed data
      }

      this.handleEvent("tour_state_save", ({state}) => {
        try {
          localStorage.setItem(this.storageKey, JSON.stringify(state))
        } catch (_error) {
          // ignore storage errors
        }
      })

      this.themeListener = ({detail}) => {
        this.pushEvent("tour_theme_changed", {theme: detail.theme})
      }
      window.addEventListener("cbs:theme-changed", this.themeListener)
    },
    destroyed() {
      if (this.themeListener) {
        window.removeEventListener("cbs:theme-changed", this.themeListener)
      }
    },
  },
  TourChecklistCopy: {
    mounted() {
      this.stepId = this.el.dataset.stepId || "ai_loop"
      this.checklist = this.el.dataset.checklist || ""
      this.clickHandler = async () => {
        try {
          await navigator.clipboard.writeText(this.checklist)
          this.pushEvent("tour_action_completed", {step_id: this.stepId})
        } catch (_error) {
          // ignore clipboard errors
        }
      }
      this.el.addEventListener("click", this.clickHandler)
    },
    destroyed() {
      if (this.clickHandler) {
        this.el.removeEventListener("click", this.clickHandler)
      }
    },
  },
}

const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
const liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: {...colocatedHooks, ...Hooks},
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

// The lines below enable quality of life phoenix_live_reload
// development features:
//
//     1. stream server logs to the browser console
//     2. click on elements to jump to their definitions in your code editor
//
if (process.env.NODE_ENV === "development") {
  window.addEventListener("phx:live_reload:attached", ({detail: reloader}) => {
    // Enable server log streaming to client.
    // Disable with reloader.disableServerLogs()
    reloader.enableServerLogs()

    // Open configured PLUG_EDITOR at file:line of the clicked element's HEEx component
    //
    //   * click with "c" key pressed to open at caller location
    //   * click with "d" key pressed to open at function component definition location
    let keyDown
    window.addEventListener("keydown", e => keyDown = e.key)
    window.addEventListener("keyup", e => keyDown = null)
    window.addEventListener("click", e => {
      if(keyDown === "c"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtCaller(e.target)
      } else if(keyDown === "d"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtDef(e.target)
      }
    }, true)

    window.liveReloader = reloader
  })
}
