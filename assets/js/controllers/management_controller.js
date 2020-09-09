import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
    deliverables: [],
    deliverable_selected: null
  },
  created: function() {
    this.channel = socket.channel("deliverable:join", {});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Vue App Management View");
        console.log(resp.deliverables);
        this.deliverables = resp.deliverables;
				console.log(this.deliverables);
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
    show_deliverable(id){
      this.channel.push("deliverable:show", {id: id})
        .receive('ok', (res) => {
          console.log("200 Success");
          this.deliverable_selected = res.deliverable;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
    new_deliverable: function(){
      this.channel.push("deliverable:new", {})
        .receive('ok', (resp) => {
					this.deliverables = resp.deliverables;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
    update: function(value, id, attr){
      this.channel.push("deliverable:update", {id: id, attr: attr, value: value})
        .receive('ok', (resp) => {
					this.deliverables = resp.deliverables;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
    delete_deliverable: function(id){
      this.channel.push("deliverable:delete", {id: id})
        .receive('ok', (resp) => {
					this.deliverables = resp.deliverables;
					this.deliverable_selected = null;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
  }
});
