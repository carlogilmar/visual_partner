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
    let user = document.getElementById("user").value;
    this.channel = socket.channel("user_home:join", {user: user});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        if(resp.definitions.length === 0){
          $('#exampleModal').modal('show');
        }
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
    save_definitions: function(){
      let user = document.getElementById("user").value;
      this.channel.push("user_home:definitions", {tags: this.tags, user: user})
        .receive('ok', (res) => {
          console.log("DONE");
          this.tags = []
          $('#exampleModal').modal('hide');
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    }
  }
});
