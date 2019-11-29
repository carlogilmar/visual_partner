import Vue from 'vue'
import socket from "./../socket"
import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.snow.css'

export const app = new Vue({
  el:"#app",
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
    email: {
      title: "cargando..",
      content: "cargando..",
      id: 0
    }
  },
  created: function() {
    console.log("Vue App here!");
    let email = document.getElementById("email").value
    this.channel = socket.channel("email:join", {email: email});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully, getting timezone data!");
        this.email = resp;
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });
  },
  components: {
    LocalQuillEditor: VueQuillEditor.quillEditor
  },
  computed: {
    editorB() {
      return this.$refs.quillEditorB.quill
    }
  },
  methods: {
  }
});
