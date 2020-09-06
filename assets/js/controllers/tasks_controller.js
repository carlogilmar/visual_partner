import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
  },
  created: function() {
    console.log("Vue App here! Tasks Controller");
    this.channel = socket.channel("tasks:join", {});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        console.log(resp);
        this.notes = resp.notes;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  }
});
