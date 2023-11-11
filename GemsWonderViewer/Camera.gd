extends Camera

func _process(_delta):
	#Prevents Zoom from being Less than 1, so it doesn't hit 0
	#because that causes a bunch of warnings in the console that are annoying 3:<
	if size < 1:
		size = 1
	
	#Shift to go Faster
	if Input.is_action_pressed("shit"):
		if Input.is_action_pressed("ui_right"):
			translation.x += 0.30
		if Input.is_action_pressed("ui_left"):
			translation.x -= 0.30
		if Input.is_action_pressed("ui_up"):
			translation.y += 0.30
		if Input.is_action_pressed("ui_down"):
			translation.y -= 0.30
		#checks if the size is larger than 1, to stop the size from going to 0 lol
		if Input.is_action_pressed("W") and size > 1:
			size -= 0.30
			translation.x += 0.01
			translation.x -= 0.01
		if Input.is_action_pressed("S"):
			size += 0.30
			translation.x += 0.01
			translation.x -= 0.01
	#Speed without Shift
	else:
		if Input.is_action_pressed("ui_right"):
			translation.x += 0.15
		if Input.is_action_pressed("ui_left"):
			translation.x -= 0.15
		if Input.is_action_pressed("ui_up"):
			translation.y += 0.15
		if Input.is_action_pressed("ui_down"):
			translation.y -= 0.15
		#checks if the size is larger than 1, to stop the size from going to 0 lol
		if Input.is_action_pressed("W") and size > 1:
			size -= 0.15
			translation.x += 0.01
			translation.x -= 0.01
		if Input.is_action_pressed("S"):
			size += 0.15
			translation.x += 0.01
			translation.x -= 0.01

#Translation Reset
func _on_Button5_pressed():
	translation.x = 0
	translation.y = 0

#Zoom Reset
func _on_Button6_pressed():
	size = 25

#puts the camera's x and y translation to the first actor in the "PlayArea" layer.
#I added this because some levels are wayyyy off 0,0
func _on_Button9_pressed():
	if get_parent().get_node("Layers/PlayArea").get_child_count() > 1:
		var actors = get_parent().get_node("Layers/PlayArea").get_children()
		translation.x = actors[0].translation.x
		translation.y = actors[0].translation.y
