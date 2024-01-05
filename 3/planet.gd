
extends Node3D

@export var distance = 10. #: set = set_distance
@export var size = 10.
@onready var body = $Body
@export var speed = 1.
# Called when the node enters the scene tree for the first time.

#func set_distance(val):
	#distance = val
	#_ready()

func _ready():
	body.position.z = distance
	scale = Vector3(size, size, size)
	body.material.albedo_color =  Color(randf_range(0.,0.5),randf_range(0.,0.5),randf_range(0.,0.5), 1.)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(speed*0.01)
