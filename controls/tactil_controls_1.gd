extends Control
@onready var right_btn: TouchScreenButton = $CanvasLayer/right_btn
@onready var left_btn: TouchScreenButton = $CanvasLayer/left_btn
@onready var jump_btn: TouchScreenButton = $CanvasLayer/jump_btn
@onready var attack_btn: TouchScreenButton = $CanvasLayer/attack_btn
@onready var dash_btn: TouchScreenButton = $CanvasLayer/dash_btn
@onready var shield_btn: TouchScreenButton = $CanvasLayer/shield_btn


func _on_right_btn_pressed() -> void:
	right_btn.set_modulate(Color(1, 1, 1, 0.6))


func _on_right_btn_released() -> void:
	right_btn.set_modulate(Color(1, 1, 1, 0.39))


func _on_left_btn_pressed() -> void:
	left_btn.set_modulate(Color(1, 1, 1, 0.6))


func _on_left_btn_released() -> void:
	left_btn.set_modulate(Color(1, 1, 1, 0.39))


func _on_jump_btn_pressed() -> void:
	jump_btn.set_modulate(Color(1, 1, 1, 0.6))


func _on_jump_btn_released() -> void:
	jump_btn.set_modulate(Color(1, 1, 1, 0.39))


func _on_attack_btn_pressed() -> void:
	attack_btn.set_modulate(Color(1, 1, 1, 0.6))


func _on_attack_btn_released() -> void:
	attack_btn.set_modulate(Color(1, 1, 1, 0.39))


func _on_dash_btn_pressed() -> void:
	dash_btn.set_modulate(Color(1, 1, 1, 0.6))


func _on_dash_btn_released() -> void:
	dash_btn.set_modulate(Color(1, 1, 1, 0.39))


func _on_shield_btn_pressed() -> void:
	shield_btn.set_modulate(Color(1, 1, 1, 0.6))


func _on_shield_btn_released() -> void:
	shield_btn.set_modulate(Color(1, 1, 1, 0.39))
