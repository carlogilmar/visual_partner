import Vue from 'vue'
import socket from "./../socket"
import Carousel3d from 'vue-carousel-3d';
Vue.use(Carousel3d);

export const app = new Vue({
  el:"#app",
  data: {
  },
  created: function() {
    console.log("Vue App here!");
  },
  methods: {
  }
});
