extends CharacterBody3D


var SPEED = 3.
const JUMP_VELOCITY = 4.5

@export var horizontal_mouse_sensitivity = 0.5
@export var vertical_mouse_sensitivity = 0.5

@export var base_speed = 5.0
@export var max_speed = 20.
@export var sprint_duration = 5.
var sprint_tween = null
var sprinting = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera_mount = $camera_mount
@onready var animation_player = $visuals/mixamo_base/AnimationPlayer
@onready var visuals = $visuals


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	SPEED = base_speed


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*horizontal_mouse_sensitivity))
		visuals.rotate_y(deg_to_rad(event.relative.x*horizontal_mouse_sensitivity))
		camera_mount.rotate_x(deg_to_rad(-event.relative.y*vertical_mouse_sensitivity))
		camera_mount.rotation_degrees.x = clamp(camera_mount.rotation_degrees.x, -90., 90.)
	if event.is_action_pressed("sprint"):
		sprinting = true
		print(sprinting)
		sprint_tween = get_tree().create_tween()
		sprint_tween.tween_property(self, "SPEED", max_speed, 1. )
		sprint_tween.tween_interval(sprint_duration)
		sprint_tween.tween_property(self, "SPEED", base_speed, 1. )
		#sprinting = false
	if event.is_action_released("sprint"):
		sprinting = false
		sprint_tween.kill()
		sprint_tween = get_tree().create_tween()
		SPEED = base_speed
		#sprint_tween.tween_property(self, "SPEED", base_speed, 1. )


var old_direction = Vector3(0.,0.,0.)
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if sprinting:
			if animation_player.current_animation != "running":
				animation_player.play("running")
		else:
			if animation_player.current_animation != "walking":
				animation_player.play("walking")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		old_direction = lerp(old_direction, position+direction, 0.25)
		visuals.look_at(old_direction)
	else:
		if animation_player.current_animation != "idle":
			animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
