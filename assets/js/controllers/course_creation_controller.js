import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
    course: {}
  },
  created: function() {
    let course = document.getElementById("course").value;
    this.channel = socket.channel("course:join", {course: course});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        console.log(resp);
        this.course = resp.course;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
    update: function(value, id, attr){
      this.channel.push("course:update", {id: id, attr: attr, value: value})
        .receive('ok', (res) => {
          console.log("DONE");
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
  }
});
