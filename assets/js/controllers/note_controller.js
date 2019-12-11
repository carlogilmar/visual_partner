import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
	el:"#app",
	data: {
    note: {}
	},
	created: function() {
		console.log("Vue App here!");
		let note = document.getElementById("note").value
		this.channel = socket.channel("note:join", {note: note});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully");
				console.log(resp);
				this.note = resp.note;
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});
	}
});
