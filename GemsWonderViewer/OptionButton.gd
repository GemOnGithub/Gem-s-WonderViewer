extends OptionButton

#gets layer node onready so I dont have to type out get_parent().get_parent().get_node("Layers")
#everytime
onready var layer = get_parent().get_parent().get_node("Layers")

#sets up all layer names and "All" as last
func _ready():
	for i in range(0, layer.get_child_count()):
		add_item(layer.get_child(i).name, i)
	add_item("All", 7)

#makes every non-selected layer Invisible, and shows every selected layer "index 6" is "All"
func _on_OptionButton_item_selected(index):
	for i in range(0, layer.get_child_count()):
		if i == index or index == 6:
			layer.get_child(i).visible = true
		else:
			layer.get_child(i).visible = false
