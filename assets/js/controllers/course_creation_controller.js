import Vue from 'vue'
import socket from "./../socket"
import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.snow.css'

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
    course: {}
  },
  created: function() {
    let course = document.getElementById("course").value;
    this.channel = socket.channel("course:join", {course: course});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully");
        console.log(resp);
        this.course = resp.course;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  methods: {
    update: function(value, id, attr){
      this.channel.push("course:update", {id: id, attr: attr, value: value})
        .receive('ok', (res) => {
          console.log("DONE");
        })
        .receive("error", resp => {
          console.log("ERROR");
        });
    }
  }
});
