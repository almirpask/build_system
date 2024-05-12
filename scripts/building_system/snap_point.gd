extends Area3D

@onready var collision = $Collision
@onready var parent: StaticBody3D = get_parent()
var in_use = false;

func _on_area_entered(area: Area3D):
	pass
	if parent.preview:
		
		parent.snap_position = parent.global_transform.origin
		#print(area.name)
		#parent.mesh.set_surface_override_material(0, parent.BLOCKED)
		pass
		
	if in_use:
		return false
	parent.current_snap_area = area
	in_use = true


func _on_area_exited(area):
	pass
	parent.current_snap_area = null
	if(parent.preview):
		#parent.move_preview(Vector3.ZERO)
		parent.mesh.position =  Vector3.ZERO
		in_use = false 
