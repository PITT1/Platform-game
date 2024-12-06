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
	if delta:
		pass
	
	var lives = get_parent().get_node("player/CharacterBody2D").lives
	
	if heartChange > lives:
		heartContainer.remove_child(heartContainer.get_child(lives))
		heartChange = lives
