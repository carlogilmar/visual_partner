import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
    note_selected: null,
    notes: []
  },
  created: function() {
    console.log("Vue App here!");
    this.channel = socket.channel("notes:join", {});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        console.log(resp);
        this.notes = resp.notes;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
    show_note:function(note_id){
      console.log("Mostrando nota");
      this.channel.push("notes:show", {note: note_id})
        .receive('ok', (res) => {
          console.log("DONE");
          console.log(res);
          this.note_selected = res.note;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    }
  }
});
