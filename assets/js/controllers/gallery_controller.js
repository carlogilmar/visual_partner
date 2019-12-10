import Vue from 'vue'
import socket from "./../socket"
import Notifications from 'vue-notification'
Vue.use(Notifications)

export const app = new Vue({
  el:"#app",
  data: {
    gallery: {},
    images: []
  },
  created: function() {
    console.log("Vue App here!");
    let gallery = document.getElementById("gallery").value
    this.channel = socket.channel("gallery:join", {gallery: gallery});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        console.log(resp);
        this.gallery = resp.gallery;
        this.images = resp.images;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
		delete_image: function(id){
			let gallery = document.getElementById("gallery").value
      this.channel.push("gallery:delete_img", {id: id, gallery: gallery})
        .receive('ok', (res) => {
          console.log("DONE");
					this.images = res.images;
          this.$notify({
            group: 'foo',
            title: 'Eliminando...',
          });
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
		},
		update_image: function(value, attr, id){
      this.channel.push("gallery:update_img", {id: id, attr: attr, value: value})
        .receive('ok', (res) => {
          console.log("DONE");
          this.$notify({
            group: 'foo',
            title: 'Guardando cambio...',
          });
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
		},
    update: function(value, attr){
      this.channel.push("gallery:update", {id: this.gallery.id, attr: attr, value: value})
        .receive('ok', (res) => {
          console.log("DONE");
          this.$notify({
            group: 'foo',
            title: 'Guardando cambio...',
          });
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
  }
});
