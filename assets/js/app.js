// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).

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

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// LIVEVIEW  (needs to go BEFORE liveSocket setup as Hooks is used in it )
let Hooks = {}

// Map stuff
import {MapCanvas} from "./map_canvas"
Hooks.WorldMapInit = {
    mounted() {
        // TODO The 400 width height shouldn't come from here?
        // TODO Maybe I could remove the width and height all together?
        // TODO Definitely remove it, it's a presentation concern as the maps as infinite.
        const onEventFromMapCanvas = (name, origin_id, payload) => {
            this.origin_id = origin_id // TODO Find a better way to do this
            this.pushEventTo(
                this.el,
                "event_from_map_canvas", 
                { name, origin_id, payload }
                )
            }

        const mapCanvas = new MapCanvas(this.el, 400, 400, onEventFromMapCanvas)


        // TODO This is being sent the same messge the same number of times there are maps on the page. This shoudln't happen
        // TODO Google multiple stateful components on same page
        const handleIncomingEvents =  
            (event) => {
                if (event.origin_id == this.origin_id) {
                    switch (event.name) {
                        case "init_map_data":
                            mapCanvas.initMapData(event.payload)
                            break;
                    } 
                }
            }

        this.handleEvent("event_for_map_canvas", handleIncomingEvents) 
    }
}


let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}})

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

