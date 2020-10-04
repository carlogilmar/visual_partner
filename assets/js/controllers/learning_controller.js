import Vue from 'vue'
import socket from "./../socket"
import VueHtml2pdf from 'vue-html2pdf'

export const app = new Vue({
  el:"#app",
  components: {
    VueHtml2pdf
  },
  data: {
    loader: true,
    enrollments:[],
		user: {name: "Visual Partner"},
		enrollment_selected: {
			title: "Visual Thinking",
			course_date: "12 de Octubre del 2010"
		}
  },
  created: function() {
    console.log("Learning Controller Vue App here!");
    let user_id = document.getElementById("user").value
    this.channel = socket.channel("learning:join", {user_id: user_id});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        console.log(resp);
        this.enrollments = resp.enrollments;
        this.loader = false;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
    generateReport () {
      this.$refs.html2Pdf.generatePdf()
    }
  }
});
