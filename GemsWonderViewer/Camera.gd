extends Camera

func _process(_delta):
	#Prevents Zoom from being Less than 1
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
