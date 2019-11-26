import {Socket} from "phoenix"

console.log("Connecting socket");
let socket = new Socket("/socket", {params: {token: ""}})

socket.connect()

export default socket
