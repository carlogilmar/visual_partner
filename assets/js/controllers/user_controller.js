import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
  },
  created: function() {
    console.log("User Here!");
    let user = document.getElementById("user").value;
    console.log(user);
  },
  methods: {
  }
});
