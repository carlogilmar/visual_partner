import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
  },
  created: function() {
    console.log("Vue App here!");
    this.channel = socket.channel("analytics:join", {});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully, getting timezone data!");
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
  }
});
