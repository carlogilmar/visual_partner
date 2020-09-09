import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
  },
  created: function() {
    this.channel = socket.channel("deliverable:join", {});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Vue App Management View");
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
  }
});
