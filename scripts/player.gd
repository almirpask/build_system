extends CharacterBody3D


const SPEED = 1.5
const JUMP_VELOCITY = 4.5
@onready var camera_mount = $CameraMount

@onready var ray_cast = $CameraMount/Camera/RayCast
@onready var cylinder = preload("res://scenes/cylinder.tscn")
@onready var texture_wood = preload("res://material/wood.tres")
@onready var texture_preview = preload("res://material/preview.tres")
var preview_instance = null
var build_mode = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var horizontal_sensitivity = 0.5
var vertical_sensitivity = 0.5

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x) * horizontal_sensitivity)
		camera_mount.rotate_x(-deg_to_rad(event.relative.y) * vertical_sensitivity)

func _physics_process(delta):
	if(ray_cast.get_collider()):
		print(ray_cast.get_collider().global_position)
	if(Input.is_action_just_pressed("build_mode")):
		if(build_mode && preview_instance != null): 
			preview_instance.queue_free()
		build_mode = !build_mode
	if(build_mode):
		if(preview_instance == null ):
			preview_instance = cylinder.instantiate()
			preview_instance.get_node("Collision").disabled  = true
			preview_instance.get_node("Mesh").set_surface_override_material(0, texture_preview)
			get_parent().add_child(preview_instance)
		if(preview_instance != null):
			preview_instance.global_position = ray_cast.get_collision_point()
			if(ray_cast.is_colliding()):
				
				if(Input.is_action_just_released("build")):
					preview_instance.get_node("Mesh").set_surface_override_material(0, texture_wood)
					preview_instance.get_node("Collision").disabled  = false		
					preview_instance = null 
			pass
				
		#print(ray_cast.get_collision_point( ))
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
