extends Node
#IDFK HOW TO DO ANY OF THIS AAAAAAAAAAAAAAAAAAAAAAAAA
#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
#FEEL FREE TO ADD SAVING TO MAKE THIS AN ACTUAL EDITOR IF YOU'D LIKE <3
var rotates = []
var trans = []
var transg = []
var scals = []

#IDFK HOW TO DO ANY OF THIS AAAAAAAAAAAAAAAAAAAAAAAAA
#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
#FEEL FREE TO ADD SAVING TO MAKE THIS AN ACTUAL EDITOR IF YOU'D LIKE <3
var yaml
onready var rand = RandomNumberGenerator.new()
var block = {
	"- AreaHash": "!u 2992145499",
		"Gyaml": "BlockRengaLight",
		"Hash": "",
		"Layer": "PlayerArea1",
		"Name": "Course001_Main.muunt/obj945",
			"Rotate": [],
			"Scale": [],
			"Translate": []
}

#IDFK HOW TO DO ANY OF THIS AAAAAAAAAAAAAAAAAAAAAAAAA
#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
#FEEL FREE TO ADD SAVING TO MAKE THIS AN ACTUAL EDITOR IF YOU'D LIKE <3
func _ready():
	yaml = preload("res://addons/godot-yaml/gdyaml.gdns").new()
	rand.randomize()


#IDFK HOW TO DO ANY OF THIS AAAAAAAAAAAAAAAAAAAAAAAAA
#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
#FEEL FREE TO ADD SAVING TO MAKE THIS AN ACTUAL EDITOR IF YOU'D LIKE <3
func _on_Button4_pressed():
	var yaml_file = File.new()
	yaml_file.open(str(get_parent().selectpath), File.READ_WRITE)
	var test = yaml.parse(yaml_file.get_as_text())
	var _testfin = test.result.values()
	rand.randomize()
	var _hashrand = rand.randi_range(1, 2147483646)
#	yaml_file.seek(yaml_file.get_len())
#	yaml_file.store_line(yaml.print(testfin[4].get("Actors")[2]))
#	print(yaml_file.get_position())
#	for n in get_parent().get_node("Placed").get_children():
#		block.Translate = n.translation
	print(yaml.print(block))
#		print(block.get("Translate"))
	

#IDFK HOW TO DO ANY OF THIS AAAAAAAAAAAAAAAAAAAAAAAAA
#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
