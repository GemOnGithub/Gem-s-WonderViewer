extends Spatial

#all of this is for block culling

#for block culling
func _ready():
	visible = true

#for block culling
func _on_VisibilityNotifier_camera_entered(_camera):
	visible = true

func _on_VisibilityNotifier_camera_exited(_camera):
	visible = false
