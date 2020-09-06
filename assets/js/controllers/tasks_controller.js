import Vue from 'vue'
import socket from "./../socket"
import VCalendar from 'v-calendar';
Vue.use(VCalendar)

export const app = new Vue({
	el:"#app",
	data: {
		attributes: [],
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
	}
});
