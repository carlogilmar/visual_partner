import Vue from 'vue'
import socket from "./../socket"

export const app = new Vue({
  el:"#app",
  data: {
    deliverables: [],
		illustrations: [{id: 1, title: "hola", url: ""}],
    deliverable_selected: null,
		new_illustration: null,
		illustration_selected: {}
  },
  created: function() {
    this.channel = socket.channel("deliverable:join", {});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Vue App Management View");
        this.deliverables = resp.deliverables;
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
					this.illustrations = res.illustrations;
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
		draft_to_private: function(id){
			this.update(false, id, "draft");
			this.deliverable_selected = null;
		},
		draft_to_public: function(id){
			this.update(true, id, "draft");
			this.deliverable_selected = null;
		},
		add_illustration: function(id, title){
      this.channel.push("deliverable:new_illustration", {id: id, title: title})
        .receive('ok', (res) => {
          console.log("200 Success");
					this.illustrations = res.illustrations;
					$('#newModal').modal('hide');
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
		},
		edit_illustration: function(illustration){
			this.illustration_selected = illustration;
		},
		update_illustration: function(value, id, attr){
      this.channel.push("deliverable:update_illustration", {id: id, attr: attr, value: value})
        .receive('ok', (resp) => {
					this.illustrations= resp.illustrations;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
		}
  }
});
