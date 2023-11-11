extends Spatial


var yaml
var mouse = Vector2()
onready var camera = get_node("Camera")
var selectpath
var accuratescaling = false
#preloads Stuff to Import
onready var groundtile = preload("res://Ground.tscn")
onready var objtile = preload("res://OBJ.tscn")
onready var camtile = preload("res://Outlineonly.tscn")

#readies the yaml addon
func _ready():
	yaml = preload("res://addons/godot-yaml/gdyaml.gdns").new()


func _on_Button_pressed():
	if selectpath != null:
		#Deletes every previously Loaded Asset
		for child in range(0, get_node("Layers").get_child_count()):
			delchildren(get_node("Layers").get_child(child))

		delchildren(get_node("Ground"))
		delchildren(get_node("ImportedCameras"))
		
		#Loads Stuff
		var yaml_file = File.new()
		yaml_file.open(str(selectpath), File.READ)
		var test = yaml.parse(yaml_file.get_as_text())
		yaml_file.close()
		var testfin = test.result.values()
		var gg = PoolVector2Array()
		var curg
		#Runs a for Loop on all Actors, then calls ActorAdd depending on the Actor's Layer.
		for i in range(0, testfin[4].get("Actors").size()):
			if testfin[4].get("Actors")[i].get("Layer").begins_with("PlayArea"):
				ActorAdd("PlayArea", i, testfin)
			if testfin[4].get("Actors")[i].get("Layer").begins_with("DecoArea"):
				ActorAdd("DecoArea", i, testfin)
			if testfin[4].get("Actors")[i].get("Layer").begins_with("DvFar"):
				ActorAdd("DvFar", i, testfin)
			if testfin[4].get("Actors")[i].get("Layer").begins_with("DvMiddle"):
				ActorAdd("DvMiddle", i, testfin)
			if testfin[4].get("Actors")[i].get("Layer").begins_with("DvPlayArea"):
				ActorAdd("DvPlayArea", i, testfin)
			if testfin[4].get("Actors")[i].get("Layer").begins_with("None"):
				ActorAdd("None", i, testfin)

		#Loads Walls
		if testfin[4].has("BgUnits"):
			for e in range(0, testfin[4].get("BgUnits").size()):
				if testfin[4].get("BgUnits")[e].has("Walls"):
					for i in range(0,testfin[4].get("BgUnits")[e].get("Walls").size()):
							for a in range(0, testfin[4].get("BgUnits")[e].get("Walls")[i].get("ExternalRail").get("Points").size()):
								var transs = str(testfin[4].get("BgUnits")[e].get("Walls")[i].get("ExternalRail").get("Points")[a].get("Translate"))
								var transsx = transs.split("[").join(" ").split("]").join(" ").split(", ").join(" ").split(" ")[1]
								var transsy = transs.split("[").join(" ").split("]").join(" ").split(", ").join(" ").split(" ")[2]
								var transsz = transs.split("[").join(" ").split("]").join(" ").split(", ").join(" ").split(" ")[3]
								#adds a new wall if it's the first point of a wall, which indicates a new wall.
								if a == 0:
									#adds the wall, randomizes the color, sets up material stuff, then appends the coords to the "gg" poolvector2array
									var newpoly = groundtile.instance()
									get_node("Ground").add_child(newpoly)
									var randmat = SpatialMaterial.new()
									var randn = RandomNumberGenerator.new()
									randn.randomize()
									randmat.albedo_color = Color.from_hsv(randn.randf_range(0.5, 1), randn.randf_range(0, 1), randn.randf_range(0.5, 0.7))
									randmat.flags_unshaded = true
									newpoly.material = randmat
									newpoly.translation.z = int(transsz)
									gg.resize(a)
									gg.append(Vector2(transsx, transsy))
									curg = newpoly
								else:
								#else appends the coords to the "gg" poolvector2array
									gg.append(Vector2(transsx, transsy))
								if a == testfin[4].get("BgUnits")[e].get("Walls")[i].get("ExternalRail").get("Points").size()-1:
								#if the current point loop is the last point in the wall, applies the translations
								#from the "gg" poolvector2array to the polygon, then deletes everything in it.
									curg.polygon = gg
									gg.resize(0)
	else:
		#If no file is selected, prints "NUH UHHH"
			print("NUH UHHH")




#Gets Transform from Actor
func transget(testfin, i):
	var arr = []
	var translate = str(testfin[4].get("Actors")[i].get("Translate"))
	arr.clear()
	arr.append(translate.split(", ")[0].lstrip("["))
	arr.append(translate.split(", ")[1])
	arr.append(translate.split(", ")[2].rstrip("]"))
	
	return arr
	
#Gets Rotation from Actor
func rotget(testfin, i):
	var arr = []
	var rotate = str(testfin[4].get("Actors")[i].get("Rotate"))
	arr.clear()
	arr.append(rotate.split(", ")[0].lstrip("["))
	arr.append(rotate.split(", ")[1])
	arr.append(rotate.split(", ")[2].rstrip("]"))
	
	return arr

#Get Scaling from Actor
func scaleget(testfin, i):
	var arr = []
	var scales = str(testfin[4].get("Actors")[i].get("Scale"))
	arr.append(scales.split(", ")[0].lstrip("["))
	arr.append(scales.split(", ")[1])
	arr.append(scales.split(", ")[2].rstrip("]"))
	
	return arr
	
#Adds Actor
func ActorAdd(addto, i, testfin):
	#takes "addto", "i" and "testfin" vars, then calls the get functions for what it needs
	#and applies it to its var
	var transl = transget(testfin, i)
	var rota = rotget(testfin, i)
	var scle = scaleget(testfin, i)
	var gyamli = str(testfin[4].get("Actors")[i].get("Gyaml"))
	var _namesi = str(testfin[4].get("Actors")[i].get("Name"))
	var _Hashi = str(testfin[4].get("Actors")[i].get("Hash"))
	#if it's not a camera, it loads in "res://OBJ.tscn", (the objtile var all the way at the top)
	#and then applies the rotation, translate, and scale (if scaling is on) from the transl rota and scle vars we just called
	if not gyamli == "CameraArea":
		var newmesh = objtile.instance()
		get_node("Layers").get_node(str(addto)).add_child(newmesh)
		if accuratescaling == false:
			newmesh.scale = Vector3(1, 1, 1)
		else:
		#if it IS a camera, always apply the scale, as it's much less obstructing.
			newmesh.scale = Vector3(scle[0], scle[1], 1)
		newmesh.rotation_degrees = Vector3(0, 0, rad2deg(float(rota[2])))
		newmesh.translation = Vector3(float(transl[0]), float(transl[1]),7)
		newmesh.get_node("CSGPolygon/Label3D").text = gyamli
		newmesh.get_node("CSGPolygon/Label3D").rotation_degrees = Vector3(0, 0, -rad2deg(float(rota[2])))
	else:
		var newmesh2 = camtile.instance()
		get_node("ImportedCameras").add_child(newmesh2)
		newmesh2.translation = Vector3(float(transl[0]), float(transl[1]), 8)
		newmesh2.scale = Vector3(scle[0], scle[1], 1)

#Delete Children Function, "node" is the input it got fed whilst being called.
func delchildren(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

#Path to Selected YAML via filedialog
func _on_FileDialog_file_selected(path):
	selectpath = path
	print(str(selectpath))

#Randomizes Ground Color, as occasionally overlapping ground colors can be too Similar
func _on_Button7_pressed():
	for ground in range(0, get_node("Ground").get_child_count()):
		var randmat = SpatialMaterial.new()
		var randn = RandomNumberGenerator.new()
		randn.randomize()
		randmat.albedo_color = Color.from_hsv(randn.randf_range(0.5, 1), randn.randf_range(0, 1), randn.randf_range(0.5, 0.7))
		randmat.flags_unshaded = true
		get_node("Ground").get_child(ground).material = randmat

#enables and disables accurate scalling, "button_pressed" returns a bool depending on
#whether the button is pressed or not, used for toggling.
func _on_Button8_toggled(button_pressed):
	if button_pressed == true:
		accuratescaling = true
	else:
		accuratescaling = false


func _on_Button10_pressed():
	#Deletes every previously Loaded Asset
	#the for loop takes each child of the "Layer" node, and then calls delchildren for each layer.
	for child in range(0, get_node("Layers").get_child_count()):
		delchildren(get_node("Layers").get_child(child))
	delchildren(get_node("Ground"))
	delchildren(get_node("ImportedCameras"))
	delchildren(get_node("Placed"))
