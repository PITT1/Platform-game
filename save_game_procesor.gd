extends Node

const save_game_path: String = "user://save_game.dat"
const LEVEL_INIT_CANVAS: Dictionary = {
	tutorial = {
		level_path = "res://levels/tutorial.tscn",
		is_level_pass = false,
		is_level_blocked = false
	},
	level_1 = {
		level_path = "res://levels/world.tscn",
		is_level_pass = false,
		is_level_blocked = true
	},
	level_2 = {
		level_path = "res://levels/world2.tscn",
		is_level_pass = false,
		is_level_blocked = true
	},
	level_3 = {
		level_path = "res://levels/world4.tscn",
		is_level_pass = false,
		is_level_blocked = true
	},
	level_4 = {
		level_path = "res://levels/world5.tscn",
		is_level_pass = false,
		is_level_blocked = true
	},
	level_5 = {
		level_path = "res://levels/world6.tscn",
		is_level_pass = false,
		is_level_blocked = true
	},
}

func init_save_game():
	if not FileAccess.file_exists(save_game_path):
		var file = FileAccess.open(save_game_path, FileAccess.WRITE)
		file.store_string(JSON.stringify(LEVEL_INIT_CANVAS))
		file.close()
		print("archivo guardado por primera vez")
	else:
		print("el archivo de guardado ya existe")


func save_game(content: String):
	var file = FileAccess.open(save_game_path, FileAccess.WRITE)
	file.store_string(content)
	file.close()


func load_game():
	print("quiero cargar")
	var file = FileAccess.open(save_game_path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content
