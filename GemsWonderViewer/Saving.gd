extends Node
#Q: "Why is this its own Node?"
#A: way more organized than having to do everything in a single script-
#- as godot doesn't allow more than 1 script on the same Node 3:<

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

#I was gonna make a template of sorts for testing, It kind of worked, however; Indents were gone
#and I couldn't find a way to do it using dictionaries so I gave up lol
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

#this was a test for saving, I tried to randomize a hash using randi (random integer) that goes from 1 to the int limit
#then it would have found the line of an actor or something, idfk. and write the stuff there.
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
