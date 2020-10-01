import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
    title: "",
    sessions: [],
    session_selected: null
  },
  created: function() {
    let course = document.getElementById("course").value;
    this.channel = socket.channel("session:join", {course: course});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        this.title = resp.title;
        this.sessions = resp.sessions;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
    new_session: function(){
      let course = document.getElementById("course").value;
      this.channel.push("session:new", {course: course})
        .receive('ok', (resp) => {
          console.log("DONE");
          this.sessions = resp.sessions;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
    show_session: function(){
      console.log("Nueva sesión");
    },
  }
});
