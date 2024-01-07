extends Node

@export var scene_resources : AllScenesMetadata
# Called when the node enters the scene tree for the first time.

@onready var title = $Chiron/Title
@onready var number = $Chiron/Number

func _ready():
	advance_scene()

func _unhandled_input(event):
	if event.is_action_pressed("Tab"):
		advance_scene()

func advance_scene():
	if scene_resources.current_scene>scene_resources.Scenes.size()-1:
		scene_resources.current_scene = 0
	var next_scene = scene_resources.Scenes[scene_resources.current_scene-1]
	scene_resources.current_scene += 1
	
	for child in $Scene.get_children():
		child.queue_free()
	var loaded_scene = next_scene.scene.instantiate()
	$Scene.add_child(loaded_scene)
	title.text = next_scene.title
	number.text = str(next_scene.number)
