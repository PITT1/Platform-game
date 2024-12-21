extends Control
@export var page_2: PackedScene
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var title: Label = $ColorRect/CenterContainer/title
@onready var label: Label = $ColorRect/VBoxContainer/Label
@onready var label_2: Label = $ColorRect/VBoxContainer/Label2
@onready var next: Button = $ColorRect/next

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lang = SaveGameProcesor.load_language()
	if lang == "spanish":
		title.set_text(SaveGameProcesor.translate.credit_page_1.title.es)
		label.set_text(SaveGameProcesor.translate.credit_page_1.label_1.es)
		label_2.set_text(SaveGameProcesor.translate.credit_page_1.label_2.es)
		next.set_text(SaveGameProcesor.translate.credit_page_1.next_btn.es)
	elif lang == "english":
		title.set_text(SaveGameProcesor.translate.credit_page_1.title.en)
		label.set_text(SaveGameProcesor.translate.credit_page_1.label_1.en)
		label_2.set_text(SaveGameProcesor.translate.credit_page_1.label_2.en)
		next.set_text(SaveGameProcesor.translate.credit_page_1.next_btn.en)
		
	animation_player.play("page_in")



func _on_next_button_up() -> void:
	var instantia = page_2.instantiate()
	get_parent().add_child(instantia)
	animation_player.play("page_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "page_out":
		queue_free()
