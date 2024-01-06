extends Node

@export var scene_resources : Array[SceneMetadata] = []
@export var current_scene = 1
# Called when the node enters the scene tree for the first time.

@onready var title = $Chiron/Title
@onready var number = $Chiron/Number

func _ready():
	print(scene_resources)
	print(scene_resources.size())
	#var root = DirAccess.open("res://")
	#
	#root.list_dir_begin()
#
	#while true:
			#var file = root.get_next()
			#if file == "":
				#break
			#if root.current_is_dir():
				#print('folder')
				#
			#elif file.ends_with("tres"):
				##file = file.get_basename()
				#scene_resources.append(file)
	#print(scene_resources)
##
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if current_scene>scene_resources.size()-1:
			current_scene = 0
		print(scene_resources[current_scene-1])
		var next_scene = scene_resources[current_scene-1]
		current_scene += 1
		
		for child in $Scene.get_children():
			child.queue_free()
		var loaded_scene = next_scene.scene.instantiate()
		$Scene.add_child(loaded_scene)
		title.text = next_scene.title
		number.text = str(next_scene.number)
