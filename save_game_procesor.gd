extends Node

const save_game_path: String = "user://save_game.dat"
const LANGUAGE_PATH: String = "user://lang.dat"

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

var select_language = "default"

var translate: Dictionary = {
	principal_menu = {
		btn_play = {
			es = "Jugar",
			en = "Play"
		},
		btn_options = {
			es = "Opciones",
			en = "Options"
		},
		btn_credits = {
			es = "Creditos",
			en = "Credits"
		},
		btn_quit = {
			es = "Salir",
			en = "Quit"
		}
	},
	menu_levels = {
		label_title = {
			es = "Niveles",
			en = "Levels"
		},
		level_1 = {
			es = "Nivel 1",
			en = "Level 1"
		},
		level_2 = {
			es = "Nivel 2",
			en = "Level 2"
		},
		level_3 = {
			es = "Nivel 3",
			en = "Level 3"
		},
		level_4 = {
			es = "Nivel 4",
			en = "Level 4"
		},
		level_5 = {
			es = "Nivel 5",
			en = "Level 5"
		},
		level_6 = {
			es = "Nivel 6",
			en = "Level 6"
		},
		btn_back = {
			es = "Atras",
			en = "Back"
		}
	},
	game_over_hud = {
		title_labe = {
			es = "FIN DEL JUEGO",
			en = "GAME OVER"
		},
		try_agai_btn = {
			es = "Volver a intentar",
			en = "Try again"
		},
		go_to_main_menu = {
			es = "Menu inicio",
			en = "Go to main menu"
		},
		quit = {
			es = "Salir",
			en = "Quit"
		}
	},
	you_win_hud = {
		title_label = {
			es = "VICTORIA",
			en = "VICTORY"
		},
		next_level = {
			es = "Siguiente nivel",
			en = "Next level"
		},
		go_to_menu_levels = {
			es = "Menu de niveles",
			en = "Go to menu levels"
		},
		try_agai_btn = {
			es = "Reiniciar",
			en = "Try again"
		},
		quit = {
			es = "Salir",
			en = "Quit"
		}
	}
}

func init_save_game():
	if not FileAccess.file_exists(save_game_path):
		var file = FileAccess.open(save_game_path, FileAccess.WRITE)
		file.store_string(JSON.stringify(LEVEL_INIT_CANVAS))
		file.close()
		print("archivo guardado por primera vez")
	else:
		print("el archivo de guardado ya existe")
	
	var saved_content = JSON.parse_string(load_data())
	
	if LEVEL_INIT_CANVAS.size() != saved_content.size():
		saved_content.merge(LEVEL_INIT_CANVAS)
		save_data(JSON.stringify(saved_content))
		print("la cantidad de niveles fue actualizada")

func save_data(content: String):
	var file = FileAccess.open(save_game_path, FileAccess.WRITE)
	file.store_string(content)
	file.close()
	
func save_language(content: String):
	var file = FileAccess.open(LANGUAGE_PATH, FileAccess.WRITE)
	file.store_string(content)
	file.close()


func load_data():
	var file = FileAccess.open(save_game_path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
func load_language():
	if FileAccess.file_exists(LANGUAGE_PATH):
		var file = FileAccess.open(LANGUAGE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		return content


func save_data_levels(current_level: String, next_level: String):
	var data = load_data()
	var data_dict: Dictionary = JSON.parse_string(data)
	var new_data = data_dict.duplicate()
	new_data[next_level]["is_level_blocked"] = false
	new_data[current_level]["is_level_pass"] = true
	save_data(JSON.stringify(new_data))

func save_data_last_level(current_level: String):
	var data = load_data()
	var data_dict: Dictionary = JSON.parse_string(data)
	var new_data = data_dict.duplicate()
	new_data[current_level]["is_level_pass"] = true
	save_data(JSON.stringify(new_data))
