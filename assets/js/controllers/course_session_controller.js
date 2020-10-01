import Vue from 'vue'
import socket from "./../socket"
import VCalendar from 'v-calendar';
Vue.use(VCalendar)

export const app = new Vue({
  el:"#app",
  data: {
    title: "",
    sessions: [],
    session_selected: null
  },
  created: function() {
    let course = document.getElementById("course").value;
    this.channel = socket.channel("session:join", {course: course});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        this.title = resp.title;
        this.sessions = resp.sessions;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
	},
	watch:{
		'session_selected.session_date'(session_date){
			this.update(session_date, this.session_selected.id, 'session_date' )
		}
	},
  methods: {
    new_session: function(){
      let course = document.getElementById("course").value;
      this.channel.push("session:new", {course: course})
        .receive('ok', (resp) => {
          console.log("DONE");
          this.sessions = resp.sessions;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
    show_session: function(id){
      console.log("Nueva sesión");
      this.session_selected = 1;
      this.channel.push("session:show", {session: id})
        .receive('ok', (resp) => {
          console.log("DONE");
          console.log(resp);
					this.parse_session(resp.session);
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
		parse_session: function(session){
			if(!session.session_date){
				session.session_date = new Date();
			}else{
				session.session_date = new Date(session.session_date);
			}
			this.session_selected = session;
		},
    algo: function(){
    console.log("me ves?");
    console.log(this.session_selected)
    this.update(this.session_selected.session_date, this.session_selected.id, 'session_date' )
    },
    update: function(value, id, attr){
      this.channel.push("session:update", {value: value, id: id, attr: attr})
        .receive('ok', (resp) => {
          console.log("DONE");
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
	}
});
