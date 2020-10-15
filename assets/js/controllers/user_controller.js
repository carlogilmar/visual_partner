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
      country: null,
      city: null,
      description: null,
      msg: '',
      tag: '',
      tags: [
				{text: "Visual Thinking", tiClasses: ["ti-valid"]}
			],
      validation: [{
        classes: 'min-length',
        rule: tag => tag.text.length > 15,
      }],
      nodes: [],
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
		validate: function(obj){
			if(obj.tag.text.length < 16){
				obj.addTag();
        this.msg = "";
			} else {
        this.msg = obj.tag.text + " es demasiado largo.";
      }
		},
		save_definitions: function(){
      let user = document.getElementById("user").value;
      this.channel.push("user_home:definitions", {tags: this.tags, user: user, city: this.city, country: this.country, description: this.description })
        .receive('ok', (res) => {
          console.log("DONE");
					console.log(res)
          this.tags = []
					this.nodes = res.definitions;
          $('#exampleModal').modal('hide');
          location.reload();
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    }
  }
});
