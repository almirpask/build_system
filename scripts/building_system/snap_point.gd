extends Area3D

@onready var collision = $Collision
@onready var parent: StaticBody3D = get_parent()
@export var snap_position: Vector3
var in_use = false;


func _process(delta):
	#collision.disabled = parent.preview
	#visible = !parent.preview
	pass
	
func _on_area_entered(area: Area3D):
	#print("ok")
	#if !parent.preview:
		#print(str(area.position))
		
		
	#if parent.preview :
		#parent.snap_position = parent.global_transform.origin
		##print(area.name)
		##parent.mesh.set_surface_override_material(0, parent.BLOCKED)
		#pass
		#
	#if in_use:
		#return false
	#parent.current_snap_area = area
	#in_use = true
	pass


func _on_area_exited(area):
	pass
	#parent.current_snap_area = null
	#if(parent.preview):
		##parent.move_preview(Vector3.ZERO)
		#parent.mesh.position =  Vector3.ZERO
		#in_use = false 


func _on_body_entered(body):
	print(body.get_instance_id())
	if "STATIC_NAME" in body:
		#print(body.STATIC_NAME)
		if body.STATIC_NAME == "PreviewObject":
			#print(body.STATIC_NAME)
			if parent.current_body != null && compare_ids(parent.current_body, body):
				parent.snap_positions.append(snap_position)
			if parent.current_body == null:
				parent.current_body = body
	pass


func _on_body_exited(body):
	print("parent.mesh.position =  Vector3.ZERO")
	#parent.mesh.position =  Vector3.ZERO
	#parent.snap_position = Vector3.ZERO
	#parent.current_body = body
	if "STATIC_NAME" in body:
		#print(body.STATIC_NAME)
		if body.STATIC_NAME == "PreviewObject":
			#print(body.STATIC_NAME)
			parent.snap_positions = parent.snap_positions.filter(func(vector) -> bool:
				return vector != snap_position
			)
			parent.current_body = null
	pass

func compare_ids(instance1, instance2):
	return instance1.get_instance_id() == instance2.get_instance_id()
