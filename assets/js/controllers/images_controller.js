import Vue from 'vue'
import VueCarousel from 'vue-carousel';
Vue.use(VueCarousel);

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
