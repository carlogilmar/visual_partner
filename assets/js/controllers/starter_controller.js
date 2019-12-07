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
        console.log("Joined successfully, getting timezone data!");
        this.get_session();
        this.socket = "😎";
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
    get_session:function(){
      let that = this;
      $.get("https://api.ipdata.co?api-key=f42a2ff8a80915a225852d8b147e7980f56e10e7ea9e2a057ca2a608", function(response) {
        that.channel.push("home:session", response);
      });
    },
  }
});
