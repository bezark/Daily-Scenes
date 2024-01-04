extends ColorRect
class_name Item

const EXTENDER = preload("res://2/Extender.tscn")

@export var title = ""
@export var cost = 0
@export var slots = 1
@onready var name_label = $MarginContainer/VBoxContainer/Name
@onready var size_label = $MarginContainer/VBoxContainer/Size
@onready var cost_label = $MarginContainer/VBoxContainer/Cost

# Called when the node enters the scene tree for the first time.
func _ready():
	name_label.text = str(title)
	size_label.text = str(slots)
	cost_label.text = str(cost)
	color = Color(randf_range(0.,0.5),randf_range(0.,0.5),randf_range(0.,0.5), 1.)


func extend():
	for x in slots-1:
		var new_item = EXTENDER.instantiate()
		new_item.create(self)
		add_sibling(new_item)
