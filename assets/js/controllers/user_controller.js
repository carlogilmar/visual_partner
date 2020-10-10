import Vue from 'vue'
import socket from "./../socket"
import VueTagsInput from '@johmun/vue-tags-input';

export const app = new Vue({
  el:"#app",
  components: {
    VueTagsInput,
  },
  data() {
    return {
      tag: '',
      tags: [],
    };
  },
  created: function() {
    console.log("User Here!");
    let user = document.getElementById("user").value;
    console.log(user);
  },
  methods: {
  }
});
