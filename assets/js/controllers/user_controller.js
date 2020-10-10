import Vue from 'vue'
import socket from "./../socket"
import VueTagsInput from '@johmun/vue-tags-input';
import { Network } from "vue-vis-network";
Vue.component('network', Network);

export const app = new Vue({
  el:"#app",
  components: {
    VueTagsInput,
  },
  data() {
    return {
      tag: '',
      tags: [],
      nodes: [
      	//{label: "Pop"},
      	//{label: "Aprender a comunicarme mejor"},
      	//{label: "Rock"},
      	//{label: "Jazz"},
      	//{label: "Hits"},
      	//{label: "Dance"},
      	//{label: "Metal"},
      	//{label: "Experimental"},
      	//{label: "Rap"},
      	//{label: "Electronic"},
      ],
      edges: [],
			options: {
				nodes: {
					borderWidth:0,
					shape:"circle",
					color:
					{background:'#F92C55', highlight:{background:'#F92C55', border: '#F92C55'}},font:{color:'#FFFFFF'}},
				physics: {
					stabilization: false,
					minVelocity:  0.05,
					solver: "repulsion",
					repulsion: {
						nodeDistance: 40
					}
				}
			}
		};
	},
  created: function() {
    let user = document.getElementById("user").value;
    this.channel = socket.channel("user_home:join", {user: user});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
				this.nodes = resp.definitions;
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
