import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
    sessions: [],
    session_selected: null
  },
  created: function() {
    let course = document.getElementById("course").value;
    this.channel = socket.channel("session:join", {course: course});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        this.sessions = resp.sessions;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
    new_session: function(){
      console.log("Nueva sesión");
    },
    show_session: function(){
      console.log("Nueva sesión");
    },
  }
});
