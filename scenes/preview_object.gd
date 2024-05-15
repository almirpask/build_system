extends StaticBody3D
class_name PreviewObject


@onready var collision: CollisionShape3D = $Collision
@onready var mesh: MeshInstance3D = $Mesh
@onready var label_3d = $Label3D
@onready var label_3d_2 = $Label3D2

const BLOCKED = preload("res://material/blocked.tres")
const PREVIEW = preload("res://material/preview.tres")
const STATIC_NAME = "PreviewObject"
var collision_objects: Array[PreviewObject] = []
var preview = false
var buildable = true 
var snap = false
var current_snap_area: Area3D = null
var snap_position: Vector3 = Vector3.ZERO
var current_body = null 
var snap_positions: Array[Vector3] = []
# Called when the node enters the scene tree for the first time.


func _ready():
	label_3d.text = name
	for i in range(get_child_count()):
		var child = get_child(i)
		#print(child.name)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label_3d_2.text = str(mesh.global_transform.origin)
	if snap_positions.size() == 0:
		mesh.position = Vector3.ZERO
	if (preview && current_body):
		mesh.global_position = current_body.global_position -  vectors_avg(snap_positions)
		#print(current_body.global_position)
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
func reset_preview_position():
	mesh.position =  Vector3.ZERO
	collision.position =  Vector3.ZERO
	
	pass
	
func sum_vectors(vectors: Array[Vector3]):
	var sum = Vector3(0,0,0)
	for vector in vectors:
		sum += vector
	return sum
func vectors_avg(vectors: Array[Vector3]):
	return sum_vectors(vectors) / vectors.size()
	

