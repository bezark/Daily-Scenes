extends ColorRect
class_name Containers


var items = null
# Called when the node enters the scene tree for the first time.
@export var title = "Eroll"
@export var capacity = 15
var filled = 0
@onready var title_label = $VBoxContainer/HBoxContainer/Title
@onready var capacity_label = $VBoxContainer/HBoxContainer/Capacity

@onready var grid_container = $VBoxContainer/GridContainer

const ITEM = preload("res://2/item.tscn")
func _ready():
	title_label.text = title
	items = get_tree().get_nodes_in_group("Item")
	for item in items:
		item.extend()
	headcount()

func update_cap_label():
	capacity_label.text = str(filled,"/",capacity)
	
func headcount():
	filled = grid_container.get_child_count()
	update_cap_label()

func _on_button_pressed():
	var new_size = randi_range(1,5)
	headcount()
	if filled+new_size <= capacity:
		var new_item = ITEM.instantiate()
		new_item.title = "new item!"
		new_item.slots = new_size
		grid_container.add_child(new_item)
		new_item.extend()
		headcount()
