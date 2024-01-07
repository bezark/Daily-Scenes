extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var base_speed = 5.0
@export var max_speed = 20.
@export var sprint_duration = 5.
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var sprint_tween = null
func _ready():
	SPEED = base_speed


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func _unhandled_input(event):
	if event.is_action_pressed("sprint"):

		sprint_tween = get_tree().create_tween()
		sprint_tween.tween_property(self, "SPEED", max_speed, 1. )
		sprint_tween.tween_interval(sprint_duration)
		sprint_tween.tween_property(self, "SPEED", base_speed, 1. )
	if event.is_action_released("sprint"):
		sprint_tween.kill()
		sprint_tween = get_tree().create_tween()
		sprint_tween.tween_property(self, "SPEED", base_speed, 1. )
		
	
