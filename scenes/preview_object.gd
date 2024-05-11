extends StaticBody3D
class_name PreviewObject


@onready var collision: CollisionShape3D = $Collision
@onready var mesh: MeshInstance3D = $Mesh

const BLOCKED = preload("res://material/blocked.tres")
const PREVIEW = preload("res://material/preview.tres")

var collision_objects: Array[PreviewObject] = []
var preview = false
var buildable = true 
var snap = false
var current_snap_area: Area3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (current_snap_area && preview):
		var delta_position = current_snap_area.global_transform.origin - mesh.global_transform.origin
		
	pass


func _on_area_3d_body_entered(body):
	if preview:
		buildable = false
		mesh.set_surface_override_material(0, BLOCKED)


func _on_area_3d_body_exited(body):
	if preview:
		buildable = true
		mesh.set_surface_override_material(0, PREVIEW)


func move_preview(new_position: Vector3):
	mesh.global_translate(new_position)
	#collision.global_translate(new_position)
func reset_preview_position():
	mesh.position =  Vector3.ZERO
	collision.position =  Vector3.ZERO

