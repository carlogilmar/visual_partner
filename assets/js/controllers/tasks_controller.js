import Vue from 'vue';
import socket from "./../socket";
import VCalendar from 'v-calendar';
import draggable from 'vuedraggable';
Vue.use(VCalendar)

export const app = new Vue({
	el:"#app",
  components: {
    draggable,
  },
	data: {
		attributes: [],
    todo: [],
    doing: [],
    done: [],
    task: { title: "", description: "...", date: new Date()},
		element: {}
	},
	created: function() {
		console.log("Vue App here! Tasks Controller");
		this.channel = socket.channel("tasks:join", {});
		this.channel.join()
			.receive("ok", resp => {
				console.log("Joined successfully");
        console.log(resp);
				this.tasks = resp.tasks;
				this.generate_calendar();
        this.todo = resp.todo;
        this.doing = resp.doing;
        this.done = resp.done;
			})
			.receive("error", resp => {
				console.log("Unable to join", resp);
			});
	},
	methods:{
		generate_calendar: function(){
			let dates = [];
			for(let index=0; index < (this.tasks.length); index++){
				let date = this.tasks[index];
				let date_for_show = {
					highlight: {backgroundColor: '#000000'},
					contentStyle: {color: '#00000'},
					popover: { label: date.title},
					dates: [new Date(date.year, (date.month-1), date.day)],
				}
				dates.push(date_for_show)
			}
			this.attributes = dates;
		},
    todo_log: function(evt) {
      if(evt.added){
        this.move_task(evt.added.element.id, "TO DO")
      }
    },
    doing_log: function(evt) {
      if(evt.added){
        this.move_task(evt.added.element.id, "DOING")
      }
    },
    done_log: function(evt) {
      if(evt.added){
        this.move_task(evt.added.element.id, "DONE")
      }
    },
    move_task: function(id, value){
      this.channel.push("tasks:move_task", {id: id, value: value})
        .receive('ok', (resp) => {
          this.todo = resp.todo;
          this.doing = resp.doing;
          this.done = resp.done;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
    unpin: function(id){
      console.log("unpinn");
      this.set_pinned(id, false);
    },
    pin: function(id){
      console.log("pinn");
      this.set_pinned(id, true);
    },
    set_pinned: function(id, value){
      this.channel.push("tasks:pinned", {id: id, value: value})
        .receive('ok', (resp) => {
          console.log("pinned");
          this.todo = resp.todo;
          this.doing = resp.doing;
          this.done = resp.done;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
		show_modal: function(element){
			this.element = element;
		},
		update:function(value, id, attr){
      this.channel.push("tasks:update", {id: id, value: value, attr: attr})
        .receive('ok', (resp) => {
          console.log("DONE");
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
		},
    onSubmit: function(){
      this.channel.push("tasks:new", this.task)
        .receive('ok', (resp) => {
          console.log("DONE");
          this.tasks = resp.tasks;
          this.generate_calendar();
          this.todo = resp.todo;
          this.doing = resp.doing;
          this.done = resp.done;
          // Cleaning Object
          this.task.title = "";
          this.task.description = "...";
          this.date = new Date();
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    }
	}
});
