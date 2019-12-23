import Vue from 'vue'
import socket from "./../socket"
import VueSlickCarousel from 'vue-slick-carousel'
import 'slick-carousel/slick/slick-theme.css'
import 'slick-carousel/slick/slick-theme.css'
Vue.use(VueSlickCarousel)


export const app = new Vue({
  el:"#app",
  data: {
  },
  created: function() {
    console.log("Vue App here!");
    //this.channel = socket.channel("apprenti:join", {});
    //this.channel.join()
    //  .receive("ok", resp => {
    //    console.log("Joined successfully, getting timezone data!");
    //  })
    //  .receive("error", resp => {
    //    console.log("Unable to join", resp);
    //  });
  }
});
