extends Control
@onready var heart: TextureRect = $CanvasLayer/HBoxContainer/TextureRect
@onready var heartContainer: HBoxContainer = $CanvasLayer/HBoxContainer

var heartsNum
var heartChange

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heartsNum = get_parent().get_node("player/CharacterBody2D").lives
	heartChange = heartsNum
	for i in range(heartsNum - 1):
		var new_heart = heart.duplicate()
		new_heart.name = "Heart_" + str(i)
		heartContainer.add_child(new_heart)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().has_node("player/CharacterBody2D"):
		heartChange = get_parent().get_node("player/CharacterBody2D").lives
		if heartsNum == heartChange:
			pass
		else:
			heartsNum = heartChange
			var childrens = heartContainer.get_children()
			if heartContainer.get_child_count() == 0:
				pass
			else:
				heartContainer.remove_child(childrens[heartsNum])
	else:
		pass
	
	
