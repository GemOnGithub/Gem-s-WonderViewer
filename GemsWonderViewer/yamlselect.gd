extends FileDialog



#pops up Yaml FileDialog and Disables Place n Erase
func _on_Button2_pressed():
	popup()
	get_parent().get_parent().get_node("Placing").placemode = false
	get_parent().get_node("Button3").pressed = false
	
