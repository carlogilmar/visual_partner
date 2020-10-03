import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
    loader: false
  },
  created: function() {
    console.log("Learning Controller Vue App here!");
    let user_id = document.getElementById("user").value
    this.channel = socket.channel("learning:join", {user_id: user_id});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        console.log(resp);
        this.loader = true;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
  }
});
