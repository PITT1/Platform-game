extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_show: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func showHud(show: bool):
	if show == true and is_show == false:
		animation_player.play("victory_in")
		is_show = true
	elif show == false and is_show == true:
		animation_player.play("victory_out")
		is_show = false


func _on_quit_btn_button_up() -> void:
	get_tree().quit()


func _on_go_to_menu_levels_btn_button_up() -> void:
	get_tree().change_scene_to_file("res://hud/menu_levels.tscn")


func _on_try_again_btn_button_up() -> void:
	var levelName = get_parent().name
	var scene_path = "res://levels/" +levelName+ ".tscn"
	get_tree().change_scene_to_file(scene_path)
