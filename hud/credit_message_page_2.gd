extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var label: Label = $ColorRect/VBoxContainer/Label
@onready var back: Button = $ColorRect/back


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lang = SaveGameProcesor.load_language()
	if lang == "spanish":
		label.set_text(SaveGameProcesor.translate.credit_page_2.label.es)
		back.set_text(SaveGameProcesor.translate.credit_page_2.back_btn.es)
	elif lang == "english":
		label.set_text(SaveGameProcesor.translate.credit_page_2.label.en)
		back.set_text(SaveGameProcesor.translate.credit_page_2.back_btn.en)
	animation_player.play("page_in")


func _on_back_button_up() -> void:
	animation_player.play("page_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "page_out":
		queue_free()
