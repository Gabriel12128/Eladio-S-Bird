extends Node2D

@onready var spawner: Marker2D = $spawner
@onready var timer_canos = $TimerCanos

#referencias entidades
@onready var player: CharacterBody2D = $player

#sons referencias
@onready var point: AudioStreamPlayer2D = $Sons/Point
@onready var Morte: AudioStreamPlayer2D = $Sons/Morte
@onready var trilha_sonora: AudioStreamPlayer2D = $"Sons/trilha sonora"
@onready var game_over: AudioStreamPlayer2D = $"Sons/Game over"


@onready var hud: Control = $HUD





#esportaveis
@export var pipe_scene: PackedScene 
@export var min_y_offset: float = -55.0 
@export var max_y_offset: float = 55.0  

#variaveis normais
var High_Score:int = 0
var score: int = 0
var pausado: bool = false

#constantes
const HIGHSCORE_FILE_PATH = "user://highscore.json"




func _ready():
	$TimerCanos.process_mode = Node.PROCESS_MODE_DISABLED 
	$spawner.process_mode = Node.PROCESS_MODE_DISABLED 
	
	
	timer_canos.timeout.connect(Geracao_Canos)
	load_high_score()
	
	
	hud.update_High_Score(High_Score)
	trilha_sonora.play()
	


#parar o processo do cano e spawner
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pulo"):
		$TimerCanos.process_mode = Node.PROCESS_MODE_ALWAYS
		$spawner.process_mode = Node.PROCESS_MODE_ALWAYS

#funçao de morte
func morte():
	hud.mostrar_hud()
	Morte.play()
	game_over.play()
	save_high_score()
	get_tree().paused = true
	
	

#acrescenta score
func increase_score():
	score += 1
	point.play()
	hud.update_Score(score)


#gera os canos
func Geracao_Canos():
	
	var pipe_instance = pipe_scene.instantiate()
	add_child(pipe_instance)

	pipe_instance.gameOver.connect(morte)
	pipe_instance.scored.connect(increase_score)

	
	var y_offset = randf_range(min_y_offset, max_y_offset)
	
	
	pipe_instance.global_position.x = spawner.global_position.x
	pipe_instance.global_position.y = spawner.global_position.y + y_offset


#acessar high score salvo
func load_high_score():
	
	if not FileAccess.file_exists(HIGHSCORE_FILE_PATH):
		print("Nenhum arquivo de high score encontrado.")
		High_Score = 0
		return
		
	
	var file = FileAccess.open(HIGHSCORE_FILE_PATH, FileAccess.READ)
	if FileAccess.get_open_error() != OK:
		
		print("Erro ao abrir o arquivo: ", FileAccess.get_open_error())
		return

	
	var content = JSON.parse_string(file.get_as_text())
	
	
	if content is Dictionary and content.has("high_score"):
		High_Score = content["high_score"]
		print("High Score Carregado: ", High_Score)
	else:
		print("Conteúdo do arquivo JSON inválido.")
		High_Score = 0
	
	file.close()

# salva high score
func save_high_score():
   
	if score > High_Score:
		High_Score = score
	  
	var content = {"high_score": High_Score}
	var json_string = JSON.stringify(content)
	  
	var file = FileAccess.open(HIGHSCORE_FILE_PATH, FileAccess.WRITE)
	if FileAccess.get_open_error() != OK:
		print("Erro ao abrir para salvar: ", FileAccess.get_open_error())
		return
			
		
	file.store_string(json_string)
	print("Novo High Score Salvo: ", High_Score)
	file.close()

# colisores do teto e chao
func _on_colisores_body_entered(_body: Node2D) -> void:
	morte()


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
