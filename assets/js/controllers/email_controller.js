import Vue from 'vue'
import socket from "./../socket"
import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.snow.css'
import Notifications from 'vue-notification'
Vue.use(Notifications)

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
					[{ 'script': 'sub' }, { 'script': 'super' }],
					[{ 'indent': '-1' }, { 'indent': '+1' }],
					[{ 'direction': 'rtl' }],
					[{ 'size': ['small', false, 'large', 'huge'] }],
					[{ 'header': [1, 2, 3, 4, 5, 6, false] }],
					[{ 'font': [] }],
					[{ 'color': [] }, { 'background': [] }],
					[{ 'align': [] }],
					['clean'],
					['link', 'image', 'video']
				],
			}
		},
		preview_email: "",
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
		update: function(value, id, attr){
			console.log(value);
			this.channel.push("email:update", {id: id, attr: attr, value: value})
				.receive('ok', (res) => {
					console.log("DONE");
					this.$notify({
						group: 'foo',
						title: 'Guardando cambio...',
					});
				})
				.receive("error", resp => {
					console.log("ERROR");
				});
		},
		update_content: function(id, attr){
			this.update(this.email.content, id, attr);
		},
		send_preview: function(){
			this.channel.push("email:preview", {id: this.email.id, email: this.preview_email})
				.receive('ok', (res) => {
					this.preview_email = "";
					this.$notify({
						group: 'foo',
						title: 'Enviando preview...',
					});
				})
				.receive("error", resp => {
					console.log("ERROR");
				});
		}
	}
});
