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
  },
  created: function() {
    console.log("Vue App here!");
    this.channel = socket.channel("email:join", {});
    this.channel.join()
      .receive("ok", resp => {
        console.log("Joined successfully, getting timezone data!");
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
