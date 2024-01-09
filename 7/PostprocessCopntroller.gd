extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(material_override.get_property_list())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
