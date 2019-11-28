import css from "../css/app.css"
import "phoenix_html"
import 'bootstrap';
import $ from 'jquery';
window.jQuery = $;
window.$ = $;

import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

let liveSocket = new LiveSocket("/live", Socket)
liveSocket.connect()
