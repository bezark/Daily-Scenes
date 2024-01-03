extends Node3D

@export var number_of_marbles = 20
const MARBLE = preload("res://1/marble.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in number_of_marbles:
		var new_marble = MARBLE.instantiate()
		new_marble.position.y = x*0.5
		add_child(new_marble)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
