extends Node
#Q: "Why is this its own Node?"
#A: way more organized than having to do everything in a single script-
#- as godot doesn't allow more than 1 script on the same Node 3:<

var mouse = Vector2()
onready var camera = get_parent().get_node("Camera")
onready var blockadd = preload("res://Placed.tscn")
var placemode = false

#turns off placemod onready
func _ready():
	placemode = false



#button toggle
func _on_Button3_toggled(button_pressed):
	if button_pressed == true:
		placemode = true
	if button_pressed == false:
		placemode = false

#checks for mouse movement, and left and right click
#upon left click, gets selection
#upon right click, erases
func _input(event):
	if event is InputEventMouse:
		mouse = event.position
		
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			get_selection()
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_RIGHT:
			erasure()


#for placing blocks, shoots a ray from camera to wall in front of camera
#then places at collision point
func get_selection():
	var worldspace = camera.get_world().direct_space_state
	var start = camera.project_ray_origin(mouse)
	var end = camera.project_position(mouse,1000)
	var result = worldspace.intersect_ray(start,end)
	if result:
		#oh boy, wacky workaround!!
		#checks if you clicked on the big grey cube I put way behind
		#if you did, it checks if placemode is on, if so, it places the block.
		if result.collider.get_parent().name == "BGWall":
			if placemode == true:
				var newblock = blockadd.instance()
				newblock.translation.x = stepify(result.position.x,0.5)
				newblock.translation.y = stepify(result.position.y,0.5)
				newblock.translation.z = 5
				get_parent().get_node("Placed").add_child(newblock)
				
#checks if clicked on placed block, if so, displays coordinates
		if result.collider.get_parent().is_in_group("Placed"):
			get_parent().get_node("SelectedCoords").set_text("Placed" + " \n" + "x: " + str(stepify(result.collider.get_parent().translation.x,0.5)) + " \n"+ "y: " + str(stepify(result.collider.get_parent().translation.y,0.5)) + " \n" + "z: " + str(0))
			get_parent().get_node("SelectedCoords/AnimationPlayer").stop(true) 
			get_parent().get_node("SelectedCoords/AnimationPlayer").play("popin")
		if result.collider.get_parent().is_in_group("Actor"):
			get_parent().get_node("SelectedCoords").set_text(str(result.collider.get_parent().get_node("CSGPolygon/Label3D").text) + " \n" + "x: " + str(stepify(result.collider.get_parent().translation.x,0.5)) + " \n"+ "y: " + str(stepify(result.collider.get_parent().translation.y,0.5)) + " \n" + "z: " + str(0))
			get_parent().get_node("SelectedCoords/AnimationPlayer").stop(true) 
			get_parent().get_node("SelectedCoords/AnimationPlayer").play("popin")


#for erasing blocks
#does the same as get selection except for the fact that it's right click
func erasure():
	var worldspace = camera.get_world().direct_space_state
	var start = camera.project_ray_origin(mouse)
	var end = camera.project_position(mouse,1000)
	var result = worldspace.intersect_ray(start,end)
	if result:
		if result.collider.get_parent().is_in_group("Placed"):
			result.collider.get_parent().queue_free()
			get_parent().get_node("SelectedCoords/AnimationPlayer").stop()
			get_parent().get_node("SelectedCoords").set_text("Placed" + " \n" + "x: " + str(stepify(result.collider.get_parent().translation.x,0.5)) + " \n"+ "y: " + str(stepify(result.collider.get_parent().translation.y,0.5)) + " \n" + "z: " + str(0))
			get_parent().get_node("SelectedCoords/AnimationPlayer").play("popout")








#All of these check if the mouse is hovering above any other Button
#to prevent placing below a button by clicking on it.

func _on_Button3_mouse_entered():
	placemode = false


func _on_Button3_mouse_exited():
	if get_parent().get_node("UIStuff/Button3").pressed == true:
		placemode = true
	else:
		placemode = false


func _on_Button_mouse_entered():
	placemode = false


func _on_Button_mouse_exited():
	if get_parent().get_node("UIStuff/Button3").pressed == true:
		placemode = true
		print(get_parent().get_node("UIStuff/Button3").pressed)
	else:
		placemode = false


func _on_Button2_mouse_entered():
	placemode = false


func _on_Button2_mouse_exited():
	if get_parent().get_node("UIStuff/Button3").pressed == true:
		placemode = true
	else:
		placemode = false


func _on_FileDialog_mouse_entered():
	placemode = false


func _on_FileDialog_mouse_exited():
	if get_parent().get_node("UIStuff/Button3").pressed == true:
		placemode = true
	else:
		placemode = false


func _on_Button4_mouse_entered():
	placemode = false


func _on_Button4_mouse_exited():
	if get_parent().get_node("UIStuff/Button3").pressed == true:
		placemode = true
	else:
		placemode = false


func _on_OptionButton_mouse_entered():
	placemode = false


func _on_OptionButton_mouse_exited():
	if get_parent().get_node("UIStuff/Button3").pressed == true:
		placemode = true
	else:
		placemode = false


func _on_OptionButton_item_focused(_index):
	get_parent().get_node("UIStuff/Button3").pressed = false
	placemode = false

func _on_OptionButton_item_selected(_index):
	get_parent().get_node("UIStuff/Button3").pressed = false
	placemode = false

func _on_OptionButton_pressed():
	get_parent().get_node("UIStuff/Button3").pressed = false
	placemode = false
