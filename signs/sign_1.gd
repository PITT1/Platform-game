extends StaticBody2D
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var level = ""
@export var id = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lang = SaveGameProcesor.load_language()
	if lang == "spanish":
		label.set_text(SaveGameProcesor.translate[level][id].es)
	elif lang == "english":
		label.set_text(SaveGameProcesor.translate[level][id].en)
	else:
		label.set_text(SaveGameProcesor.translate[level][id].es)

func _on_letter_area_body_entered(body: Node2D) -> void:
	if body:
		animation_player.play("show_message")


func _on_letter_area_body_exited(body: Node2D) -> void:
	if body:
		animation_player.play("hide_message")
