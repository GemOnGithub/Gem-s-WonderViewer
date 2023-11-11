extends Node
#Q: "Why is this its own Node?"
#A: way more organized than having to do everything in a single script-
#- as godot doesn't allow more than 1 script on the same Node 3:<

#adds a function signal for if a file is dropped in the window.
func _ready():
	get_tree().connect("files_dropped", self, "_on_files_dropped")

#function triggered by the signal if a file is dropped on the window, "files" is the files selected
#"screen" is probably the screen it got dropped on, idk, I didn't need it.
func _on_files_dropped(files, screen):
	if files[0].ends_with(".yaml"):
		get_parent().selectpath = files[0]
		print(files[0])
