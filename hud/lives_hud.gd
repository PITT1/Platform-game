extends Control
@onready var heart: TextureRect = $CanvasLayer/HBoxContainer/TextureRect
@onready var heartContainer: HBoxContainer = $CanvasLayer/HBoxContainer
@onready var anim: AnimatedSprite2D = $CanvasLayer/HBoxContainer2/AnimatedSprite2D
@onready var coin_label: Label = $CanvasLayer/HBoxContainer2/Label

var heartsNum
var heartChange

var total_coins: int
var coins_num: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heartsNum = get_parent().get_node("player/CharacterBody2D").lives
	heartChange = heartsNum
	for i in range(heartsNum - 1):
		var new_heart = heart.duplicate()
		new_heart.name = "Heart_" + str(i)
		heartContainer.add_child(new_heart)
	
	anim.play("coin")
	
	for i in get_parent().get_child_count():
		if get_parent().get_child(i).name == "coins":
			total_coins = get_parent().get_child(i).get_child_count()
			coin_label.set_text("0/" + str(total_coins))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if delta:
		pass
	
	var lives = get_parent().get_node("player/CharacterBody2D").lives
	
	if heartChange > lives:
		heartContainer.remove_child(heartContainer.get_child(lives))
		heartChange = lives
