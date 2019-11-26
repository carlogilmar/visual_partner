import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
    socket: "💀"
  },
  created: function() {
    console.log("Vue App here!");
    this.channel = socket.channel("home:join", {});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        this.socket = "😎";
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
  }
});
