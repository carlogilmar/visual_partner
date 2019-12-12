import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
    note: {},
    username: "",
    comment: "",
    comments: []
  },
  created: function() {
    console.log("Vue App here!");
    let note = document.getElementById("note").value
    this.channel = socket.channel("note:join", {note: note});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        console.log(resp);
        this.note = resp.note;
        this.comments = resp.comments;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods:{
    create_comment:function(){
      console.log("Que onda!");
      let id = document.getElementById("note").value
      this.channel.push("note:new_comment", {id: id, username: this.username, comment: this.comment})
        .receive('ok', (res) => {
					this.comments = res.comments;
					this.username= "";
					this.comment= "";
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    }
  }
});
