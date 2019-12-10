import Vue from 'vue'
import VueCarousel from 'vue-carousel';
import socket from "./../socket"
Vue.use(VueCarousel);

export const app = new Vue({
  el:"#app",
  data: {
    images: [],
    gallery: {}
  },
  created: function() {
    console.log("Vue App here!");
    let gallery = document.getElementById("gallery").value
    this.channel = socket.channel("gallery:join", {gallery: gallery});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        console.log(resp);
        this.images = resp.images;
        this.gallery = resp.gallery;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
  }
});
