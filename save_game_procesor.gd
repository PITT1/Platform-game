extends Node

const save_game_path: String = "user://save_game.dat"
const LANGUAGE_PATH: String = "user://lang.dat"

var coins_count: int
var timer_level: float = 0.0

const LEVEL_INIT_CANVAS: Dictionary = {
	tutorial = {
		level_path = "res://levels/escene_levels/tutorial.tscn",
		is_level_pass = false,
		is_level_blocked = false,
		best_time = 0.00,
		is_all_coins_collected = false,
		is_no_hit = false
	},
	level_1 = {
		level_path = "res://levels/escene_levels/world_1.tscn",
		is_level_pass = false,
		is_level_blocked = true,
		best_time = 0.00,
		is_all_coins_collected = false,
		is_no_hit = false
	},
	level_2 = {
		level_path = "res://levels/escene_levels/world_2.tscn",
		is_level_pass = false,
		is_level_blocked = true,
		best_time = 0.00,
		is_all_coins_collected = false,
		is_no_hit = false
	},
	level_3 = {
		level_path = "res://levels/escene_levels/world_3.tscn",
		is_level_pass = false,
		is_level_blocked = true,
		best_time = 0.00,
		is_all_coins_collected = false,
		is_no_hit = false
	},
	level_4 = {
		level_path = "res://levels/escene_levels/world_4.tscn",
		is_level_pass = false,
		is_level_blocked = true,
		best_time = 0.00,
		is_all_coins_collected = false,
		is_no_hit = false
	},
	level_5 = {
		level_path = "res://levels/escene_levels/world_5.tscn",
		is_level_pass = false,
		is_level_blocked = true,
		best_time = 0.00,
		is_all_coins_collected = false,
		is_no_hit = false
	},
	level_6 = {
		level_path = "res://levels/escene_levels/world_6.tscn",
		is_level_pass = false,
		is_level_blocked = true,
		best_time = 0.00,
		is_all_coins_collected = false,
		is_no_hit = false
	},
	level_7 = {
		level_path = "res://levels/escene_levels/world_7.tscn",
		is_level_pass = false,
		is_level_blocked = true,
		best_time = 0.00,
		is_all_coins_collected = false,
		is_no_hit = false
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
		level_7 = {
			es = "Nivel 7",
			en = "Level 7"
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
			es = "¡VICTORIA!",
			en = "VICTORY!"
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
	},
	level_1 = {
		id_0 = {
			es = "Bienvenido :D, primeramente dejame enseñarte a jugar, puedes empezar con moverte de izquierda a derecha con los botones direccionales",
			en = "Welcome :D, first let me show you how to play, you can start by moving from left to right with the directional buttons"
		},
		id_1 = {
			es = "Usa el boton de salto para superar los siguientes obstaculos, es el que esta abajo a la derecha de tu pantalla",
			en = "Use the jump button to overcome the following obstacles, it is the one at the bottom right of your screen"
		},
		id_2 = {
			es = "Si mantienes pulsado el botón de salto, puedes elevarte mucho más alto en el aire",
			en = "If you hold down the jump button, you can rise much higher in the air"
		},
		id_3 = {
			es = "No hay daño por caida, por lo tanto podras caer desde donde quieras y siempre saldras ileso",
			en = "There is no fall damage, therefore you can fall from wherever you want and you will always come out unscathed."
		},
		id_4 = {
			es = "Hora de aprender a trepar paredes",
			en = "Time to learn to climb walls"
		},
		id_5 = {
			es = "Salta hacia una pared y cuando la toques, salta denuevo para realizar un salto diagonal",
			en = "Jump towards a wall and when you touch it, jump again to perform a diagonal jump"
		},
		id_6 = {
			es = "Para hacer el salto diagonal correctamente tienes que mantener pulsado los botones direccionales en direccion a la pared que estas saltando",
			en = "To do the diagonal jump correctly you have to hold down the directional buttons in the direction of the wall you are jumping"
		},
		id_7 = {
			es = "Es un poco dificil al principio pero te acostumbraras :D",
			en = "It's a little difficult at first but you'll get used to it :D"
		},
		id_8 = {
			es = "Intenta practicar saltos diagonales consecutivos con el siguiente obstaculo",
			en = "Try practicing consecutive diagonal jumps with the following obstacle"
		},
		id_9 = {
			es = "Para los siguientes obstaculos tendras que usar el avance rapido, el boton que esta justo arriba del boton de salto",
			en = "For the next obstacles you will have to use dash, the button just above the jump button"
		},
		id_10 = {
			es = "Usa el avance rapido mientras estas en el aire y podras recorrer mayores distancias",
			en = "Use dash while you are in the air and you will be able to travel greater distances"
		},
		id_11 = {
			es = "Usa el avance rapido mientras estas en el suelo y rapidamente deja pulsado el boton de salto para realizar un salto largo",
			en = "Use dash while on the ground and quickly press and hold the jump button to perform a long jump"
		},
		id_12 = {
			es = "Usa el boton de ataque golpear a tus enemigos, es el que tiene el icono de usa espada",
			en = "Use the attack button to hit your enemies, it is the one with the sword icon"
		},
		id_13 = {
			es = "Trata de saltar siempre que quieras atacar, los ataques en el aire hacen el doble de daño",
			en = "Try to jump whenever you want to attack, attacks in the air do double damage"
		},
		id_14 = {
			es = "Usa ataque + salto para realizar un combo de 2 ataques consecutivos",
			en = "Use attack + jump to perform a combo of 2 consecutive attacks"
		},
		id_15 = {
			es = "Buena suerte :D",
			en = "Good luck :D"
		}
	},
	credit_page_1 = {
		title = {
			es = "Tiny Brave",
			en = "Tiny Brave"
		},
		label_1 = {
			es = "Este juego fue creado por: \nPedro Torrez, GitHub: https://github.com/PITT1",
			en = "This game was created by: \nPedro Torrez, GitHub: https://github.com/PITT1"
		},
		label_2 = {
			es = "Contenido Adicional: \nAssets, Sprites, Sonido y Música: \nTodos los elementos visuales y auditivos\n utilizados en este juego \nprovienen de recursos gratuitos \ny de libre uso encontrados en itch.io y\n YouTube. \nEstoy agradecido por la comunidad que hace \nposible el arte del codigo libre",
			en = "Additional Content: \nAssets, Sprites, Sound and Music: \nAll visual and auditory elements\n used in this game come \nfrom free resources and free to use \nfound on itch.io and\n YouTube. \nI am grateful for the community that makes possible \nthe art of open source"
		},
		next_btn = {
			es = "Continuar",
			en = "continue"
		}
	},
	credit_page_2 = {
		label = {
			es = "Objetivo del Proyecto: \nEste juego ha sido desarrollado \nprincipalmente con el fin de mejorar las habilidades de programación de su creador. \nGracias por jugar :,)",
			en = "Project Objective: \nThis game has been developed mainly \nin order to improve the programming skills of its creator. \nThanks for playing :,)"
		},
		back_btn = {
			es = "Menu principal",
			en = "Main menu"
		}
	},
	pause_menu = {
		title = {
			es = "¡PAUSA!",
			en = "PAUSE!"
		},
		resume_btn = {
			es = "Reanudar",
			en = "Resume"
		},
		options_btn = {
			es = "Opciones",
			en = "Options"
		},
		menu_levels_btn = {
			es = "Menu de niveles",
			en = "go to menu levels"
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
		saved_content.merge(LEVEL_INIT_CANVAS, false)
		save_data(JSON.stringify(saved_content))
		print("se hizo merge en el save_game_path")

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

func save_best_time(level_name: String, is_all_coins: bool, is_no_hit_play: bool):
	var data = load_data()
	var data_dict: Dictionary = JSON.parse_string(data)
	data_dict[level_name]["best_time"] = timer_level
	data_dict[level_name]["is_all_coins_collected"] = is_all_coins
	data_dict[level_name]["is_no_hit"] = is_no_hit_play
	save_data(JSON.stringify(data_dict))
	
