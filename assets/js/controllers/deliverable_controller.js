import Vue from 'vue'
import VueCarousel from 'vue-carousel';
import socket from "./../socket"
Vue.use(VueCarousel);

export const app = new Vue({
  el:"#app",
  data: {
    draft: false,
    images: [],
		deliverable: ""
  },
  created: function() {
    console.log("Deliverables Vue App here!");
    let deliverable = document.getElementById("deliverable").value
    this.channel = socket.channel("deliverables:join", {deliverable: deliverable});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
				this.images = resp.illustrations;
				this.deliverable = resp.deliverable;
        this.draft = resp.draft;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
  }
});
