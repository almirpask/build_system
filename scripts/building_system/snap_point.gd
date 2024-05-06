extends Area3D

@onready var collision = $Collision
@onready var parent: StaticBody3D = get_parent()

func _on_area_entered(area):
	parent.current_snap_area = area


func _on_area_exited(area):
	parent.current_snap_area = null
	if(parent.preview):
		parent.move_preview(Vector3.ZERO)
		parent.mesh.position =  Vector3.ZERO
