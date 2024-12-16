extends Node

const save_game_path: String = "user://save_game.dat"
const LEVEL_INIT_CANVAS: Dictionary = {
	tutorial = {
		level_path = "res://levels/escene_levels/tutorial.tscn",
		is_level_pass = false,
		is_level_blocked = false
	},
	level_1 = {
		level_path = "res://levels/escene_levels/world_1.tscn",
		is_level_pass = false,
		is_level_blocked = true
	},
	level_2 = {
		level_path = "res://levels/escene_levels/world_2.tscn",
		is_level_pass = false,
		is_level_blocked = true
	},
	level_3 = {
		level_path = "res://levels/escene_levels/world_3.tscn",
		is_level_pass = false,
		is_level_blocked = true
	},
	level_4 = {
		level_path = "res://levels/escene_levels/world_4.tscn",
		is_level_pass = false,
		is_level_blocked = true
	},
	level_5 = {
		level_path = "res://levels/escene_levels/world_5.tscn",
		is_level_pass = false,
		is_level_blocked = true
	},
	level_6 = {
		level_path = "res://levels/escene_levels/world_6.tscn",
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
	
	var saved_content = JSON.parse_string(load_game())
	
	if LEVEL_INIT_CANVAS.size() != saved_content.size():
		saved_content.merge(LEVEL_INIT_CANVAS)
		save_game(JSON.stringify(saved_content))
		print("la cantidad de niveles fue actualizada")

func save_game(content: String):
	var file = FileAccess.open(save_game_path, FileAccess.WRITE)
	file.store_string(content)
	file.close()


func load_game():
	var file = FileAccess.open(save_game_path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content

func save_data_levels(current_level: String, next_level: String):
	var data = load_game()
	var data_dict: Dictionary = JSON.parse_string(data)
	var new_data = data_dict.duplicate()
	new_data[next_level]["is_level_blocked"] = false
	new_data[current_level]["is_level_pass"] = true
	save_game(JSON.stringify(new_data))

func save_data_last_level(current_level: String):
	var data = load_game()
	var data_dict: Dictionary = JSON.parse_string(data)
	var new_data = data_dict.duplicate()
	new_data[current_level]["is_level_pass"] = true
	save_game(JSON.stringify(new_data))
