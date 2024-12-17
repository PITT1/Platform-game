extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("hud_in")
	if not FileAccess.file_exists(SaveGameProcesor.LANGUAGE_PATH):
		SaveGameProcesor.save_language(SaveGameProcesor.select_language)
		print("archivo de idioma creado")


func _on_btn_spanish_button_up() -> void:
	SaveGameProcesor.save_language("spanish")
	animation_player.play("hud_out")


func _on_btn_english_button_up() -> void:
	SaveGameProcesor.save_language("english")
	animation_player.play("hud_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hud_out":
		get_tree().reload_current_scene()
