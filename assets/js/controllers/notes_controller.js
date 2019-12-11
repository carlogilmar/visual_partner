import Vue from 'vue'
import socket from "./../socket"
import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.snow.css'
import Notifications from 'vue-notification'
Vue.use(Notifications)

export const app = new Vue({
  el:"#app",
  components: {
    LocalQuillEditor: VueQuillEditor.quillEditor
  },
  computed: {
    editorB() {
      return this.$refs.quillEditorB.quill
    }
  },
  data: {
    editorOption: {
      theme: 'snow',
      modules: {
				toolbar: [
					[{ header: [1, 2, false] }],
					['bold', 'italic', 'underline'],
					['image', 'code-block']
				]
			}
    },
    note_selected: null,
    notes: []
  },
  created: function() {
    console.log("Vue App here!");
    this.channel = socket.channel("notes:join", {});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        console.log(resp);
        this.notes = resp.notes;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
    update: function(value, id, attr){
      this.channel.push("notes:update", {id: id, attr: attr, value: value})
        .receive('ok', (res) => {
          console.log("DONE");
          this.notes = res.notes;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
    update_body: function(id, attr){
      this.update(this.note_selected.body, id, attr);
    },
    show_note:function(note_id){
      console.log("Mostrando nota");
      this.channel.push("notes:show", {note: note_id})
        .receive('ok', (res) => {
          console.log("DONE");
          console.log(res);
          this.note_selected = res.note;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
    new_note: function(){
      this.channel.push("notes:new", {})
        .receive('ok', (res) => {
          this.notes = res.notes;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
    delete_note: function(id){
      this.channel.push("notes:delete", {id: id})
        .receive('ok', (res) => {
          this.notes = res.notes;
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    },
  }
});
