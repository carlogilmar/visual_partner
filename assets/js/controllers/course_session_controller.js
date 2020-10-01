import Vue from 'vue'
import socket from "./../socket"
import VCalendar from 'v-calendar';
import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.snow.css'
Vue.use(VCalendar)

export const app = new Vue({
  el:"#app",
  data: {
    editorOption: {
      theme: 'snow',
      modules: {
        toolbar: [
          ['bold', 'italic', 'underline', 'strike'],
          ['blockquote', 'code-block'],
          [{ 'header': 1 }, { 'header': 2 }],
          [{ 'list': 'ordered' }, { 'list': 'bullet' }],
          [{ 'size': ['small', false, 'large', 'huge'] }],
          [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
          [{ 'font': [] }],
          [{ 'color': [] }, { 'background': [] }],
          [{ 'align': [] }],
          ['link', 'image', 'video']
        ],
      }
    },
    title: "",
    sessions: [],
    session_selected: {feedback: "Sin llenar", session_date: new Date(), items: []},
    agenda_task: null
  },
  components: {
    LocalQuillEditor: VueQuillEditor.quillEditor
  },
  computed: {
    editorB() {
      return this.$refs.quillEditorB.quill
    }
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
    update: function(value, id, attr){
      if(value && attr && id){
        this.channel.push("session:update", {value: value, id: id, attr: attr})
          .receive('ok', (resp) => {
            console.log("DONE");
          })
          .receive("error", resp => {
            console.log("ERROR");
          });
      }else{
        console.log("unexpected error");
      }
    },
    add_new_task: function(){
      this.channel.push("session:add_task", {id: this.session_selected.id, description: this.agenda_task})
        .receive('ok', (resp) => {
          console.log("DONE");
          console.log(resp);
          this.agenda_task = null;
          this.session_selected.items = resp.items;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
    update_item: function(value, id, attr){
      this.channel.push("session:update_item", {value: value, id: id, attr: attr})
        .receive('ok', (resp) => {
          console.log("DONE");
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    }
  }
});
