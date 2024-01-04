extends ColorRect
class_name Extender

@export var parent_item : Item
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	add_to_group("extender")
	size = Vector2i(128,128)


func create(p_item):
	parent_item = p_item
	color = parent_item.color
